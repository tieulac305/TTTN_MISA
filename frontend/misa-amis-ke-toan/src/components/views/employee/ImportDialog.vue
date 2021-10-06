<template>
<div>
    <div class="form-dialog dialog" 
        @keyup.esc.exact = "close()">
        <div class="cover-background" @click="close()"></div>
        <vue-resizable
            :width="600"
            :height="`300px`"
            :left="`50%`"
            :top="`calc(100vh/2)`"
            :dragSelector="'.modal-content, .modal-footer, .modal-header'"
            :fit-parent="false"
            class="modal-content d-flex"
        >
            <!-- header -->
            <div class="modal-header d-flex">
                <div class="left">
                    <div class="modal-title title d-flex">Thêm nhiều nhân viên</div>
                </div>
                <div class="d-flex">
                    <div class="icon help-icon" 
                        v-tooltip.bottom="'Trợ giúp'" @click="helpStatus = true;"></div>
                    <div class="icon close-icon"
                        v-tooltip.bottom="'Đóng (ESC)'" @click="close()"></div>
                </div>
            </div>
            <!-- form -->
            <div class="modal-body d-flex">
                <input type="file" name="employeeFile"
                    id="employeeFile" accept=".xlsx" hidden
                    @change="uploadFile">
                <label for="employeeFile" class="d-flex file-chooser"
                    v-show="!isProcessing">
                    <div class="icon add-icon"></div>
                    <div style="font-size: 14px">{{msg}}</div>
                    <div class="error-msg" style="color: red; font-size: 14px"
                        v-show="isError">
                        Vui lòng chọn tệp đúng định dạng.
                    </div>
                </label>
                <div v-show="isProcessing" class="d-flex file-chooser">
                    <div class="icon done-icon"></div>
                    <div style="font-size: 14px">Hệ thống đang xử lí tệp của bạn.</div>
                    <div style="font-size: 14px">Vui lòng chờ trong giây lát.</div>
                </div>
            </div>
            <!-- phần cuối -->
            <div class="modal-footer d-flex">
                <button type="button" class="btn btn-secondary"
                    v-tooltip="'Đóng hộp thoại'"
                    @click="$emit('close')" >Hủy</button>
                <button class="btn btn-primary"
                    v-tooltip="'Thêm'"
                    :disabled="!file || isProcessing"
                    @click="addMultiple">
                    Thêm từ tệp đã chọn
                </button>
            </div>
        </vue-resizable>
    </div>
    <!-- popup help chứa schema -->
    <import-help-dialog v-show="helpStatus" @close="helpStatus = false;"/>
    <!-- đặt chỗ cho popup-->
    <pop-up v-if="popup.popupStatus" :modal="popup.modal" @close="closePopUp()"/>
</div>
</template>

<script>
import readXlsxFile from 'read-excel-file'
// vue-resizable
import VueResizable from "vue-resizable"
// common
import Resource from '../../../js/common/Resource.js'
import Enum from '../../../js/common/Enum.js'
//api
import apiEmployee from '../../../js/api/EmployeeAPI'
import apiDepartment from '../../../js/api/DepartmentAPI'
// component
import PopUp from '../../base/PopUp.vue'
import ImportHelpDialog from './ImportHelpDialog.vue'

export default {
    name: 'ImportDialog',
    components:{
        PopUp,
        VueResizable,
        ImportHelpDialog
    },
    data(){
        return {
            // file
            file: null,
            // tin đi kèm
            msg: "Nhấn để chọn tệp (*.xlsx)",
            isError: false,
            isProcessing: false,
            helpStatus: false,
            // popup
            popup: {
                popupStatus: false,
                modal:{},
            },
            // làm cho form có thể drag
            resizable: {
                draggable: '.modal-header, .modal-footer',
                handlers: [],
            },
            // mapping data
            mapDict: {
                departmentId: {
                    '' : null
                },
                gender: {
                    'Nam' : 1,
                    'Nữ' : 0,
                    'Khác' : 2,
                    '' : null
                }
            }
        }
    },
    methods:{
        /**
         * đóng dialog
         * Author: CpNam 17.07.2021
         */
        close(){
            let me=this;
            if (me.file)
                me.openPopUp({
                    message: `Tệp đã được upload. Bạn có muốn thêm không?`,
                    cancelText: 'Hủy',
                    noText: 'Không',
                    continueText: 'Có',
                    modalMode: Resource.PopUpMode.Question,
                    callbackNoFunc: ()=>{
                        me.$emit('close');
                    },
                    callbackOkFunc: ()=>{
                        console.log('đã thêm');
                    }
                });
            else me.$emit('close');
        },
        /**
         * tạo popup mới
         * Author: CpNam 17.07.2021
         */
        openPopUp(modal){
            this.popup.modal = modal;
            this.popup.popupStatus = true;
        },
        /**
         * đóng popup
         * Author: CpNam 17.07.2021
         */
        closePopUp(){
            this.popup.popupStatus = false;
        },
        /**
         * mở 1 popup lỗi
         * Author: CpNam 21.08.2021
         */
        errorPopUp(msg){
            // build message
            let message = `<div style="font-size: 15px; padding-bottom: 6px;">${Resource.Message.Exception}</div>`;
            if(msg){
                message += `<b>Lỗi: </b>` + msg;
            }

            this.openPopUp({
                message: message,
                continueText: 'Đồng ý',
                modalMode: Resource.PopUpMode.Warning,
                callbackOkFunc: ()=>{
                    this.$emit('close');
                }
            });
        },
        /**
         * mở toast
         * Author: CpNam 05.10.2021
         */
        openToast(msg, mode){
            this.$emit('toast', msg, mode);
        },
        /**
         * khi chọn file
         * Author: CpNam 06.10.2021
         */
        uploadFile(event){
            let me = this;
            me.isError = false;

            if(event.target.files.length == 0){
                me.file = null;
                me.msg = 'Nhấn để chọn tệp (*.xlsx)';
            }
            else{
                me.file = event.target.files[0];
                me.msg = 'Tệp đã chọn: ' + me.file.name;

                if(me.file.name.split('.').slice(-1)[0] != 'xlsx'){
                    me.isError = true;
                    me.file = null;
                }
            }
        },
        /**
         * map data từ bên ngoài thành data để server hiểu
         * Author: CpNam 06.10.2000
         */
        async employeeMapping(employees){
            let me = this;
            // chờ lấy dữ liệu
            try {
                let res = await apiDepartment.getDepartments();
                res.data.data.forEach(item => {
                    me.mapDict.departmentId[item.departmentName] = item.departmentId;
                });
                // map
                employees.forEach(emp => {
                    emp.departmentId = me.mapDict.departmentId[emp.departmentName];
                    emp.gender = me.mapDict.gender[emp.genderName];
                });
            } catch (err) {
                me.errorPopUp();
            }
        },
        /**
         * kiểm tra hợp lệ dữ liệu
         * Author: CpNam 06.10.2021
         */
        validate(employees){
            let me = this,
                len = employees.length;
            
            // kiểm tra các trường
            for(let i=0; i<len ; i++){
                if(!employees[i].departmentName){
                    me.errorPopUp("Phòng ban không được bỏ trống.<br> Dòng thứ: " + (i+1));
                    return false;
                }
                if(!employees[i].departmentId){
                    console.log(employees[i].departmentId)
                    me.errorPopUp("Phòng ban không tồn tại.<br> Dòng thứ: " + (i+1));
                    return false;
                }
                if(!employees[i].employeeCode){
                    me.errorPopUp("Mã nhân viên không được bỏ trống.<br> Dòng thứ: " + (i+1));
                    return false;
                }
                if(!employees[i].employeeName){
                    me.errorPopUp("Tên nhân viên không được bỏ trống.<br> Dòng thứ: " + (i+1));
                    return false;
                }
            }
            return true;
        },
        /**
         * gửi dữ liệu từ file xlsx
         * Author: CpNam 06.10.2000
         */
        sentData(){
            let me = this;
            // lấy data từ file
            readXlsxFile(me.file, { schema: Resource.Schema.EmployeeImport})
            .then(async ({rows})=>{
                let employees = rows;
                // xử lí mapping data
                await me.employeeMapping(employees);
                // validate data
                if (me.validate(employees)){
                    // gửi lên server nếu valid
                    apiEmployee.insertMultiple(employees)
                    .then((response)=>{
                        // dữ liệu không hợp ý server
                        if(response.data.misaCode == Enum.MISACode.Invalid){
                            me.errorPopUp(response.data.messenger + `<br>Bản ghi thứ: ` + response.data.data);
                        }
                        else{
                            // sửa thành công nên gửi toast
                            me.openToast('Thêm mới thành công.', Resource.ToastMesengerMode.Success);
                            // nếu bấm cất thì muốn đóng, nếu bấm cất và thêm thì k đóng
                            me.$emit('close');
                        }
                    })
                    .catch((res)=>{
                        me.errorPopUp();
                        console.log(res, "");
                    });
                }
            })
            .catch(()=>{
                me.errorPopUp('Xảy ra lỗi khi đọc tệp.');
            });
        },
        /**
         * thêm nhiều một lúc
         * Author: CpNam 06.10.2021
         */
        addMultiple(){
            let me = this;
            me.isProcessing = true;

            // chờ 1s để tránh spam
            setTimeout(me.sentData,1000);
        }
    }
}
</script>

<style scoped>
    @import url('../../../css/common/dialog.css');

    .modal-body{
        justify-content: center;
    }
    .file-chooser{
        flex-flow: column;
        align-items: center;
        margin-top: 20px;
        cursor: pointer;
    }
    .file-chooser .icon{
        margin-left: 0;
        margin-bottom: 10px;
    }
</style>
