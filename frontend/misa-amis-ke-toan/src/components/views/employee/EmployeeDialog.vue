<template>
<div>
    <div class="form-dialog dialog" 
        @keyup.esc.exact = "close()"
        @keyup.ctrl.77.exact = "wannaClose=true; saveEmployee();">
        <div class="cover-background" @click="close()"></div>
        <vue-resizable
            :width="800"
            :height="`fit-content`"
            :left="`50%`"
            :top="`calc(100vh/2)`"
            :dragSelector="'.modal-content, .modal-footer, .modal-header'"
            :fit-parent="false"
            class="modal-content d-flex"
        >
            <!-- header -->
            <div class="modal-header d-flex">
                <div class="left">
                    <div class="modal-title title d-flex">Thông tin nhân viên</div>
                    <label class="checkbox-wrapper flex items-center">
                        <input class="checkbox" type="checkbox"  name="is-customer" id="is-customer"/>
                        <span class="checkmark"></span>
                        <label for="is-customer">Là khách hàng</label>
                    </label>
                    <label class="checkbox-wrapper flex items-center">
                        <input class="checkbox" type="checkbox" name="is-supplier" id="is-supplier"/>
                        <span class="checkmark"></span>
                        <label for="is-supplier">Là nhà cung cấp</label>
                    </label>
                </div>
                <div class="d-flex">
                    <div class="icon help-icon" v-tooltip.bottom="'Trợ giúp'"></div>
                    <div class="icon close-icon" v-tooltip.bottom="'Đóng (ESC)'" @click="close()"></div>
                </div>
            </div>
            <!-- form -->
            <div class="modal-body d-flex">
                <form role="form" class="width-100">
                    <div class="row">
                        <div class="col col-1">
                            <div class="row">
                                <div class="form-group width-40">
                                    <label class="control-label">Mã <span style="color: red;">*</span></label>
                                    <input class="form-control" name="EmployeeCode"
                                        spellcheck="false"
                                        v-model="Employee.employeeCode" ref="EmployeeCode"
                                        v-validate="'required|max:20'"
                                        :class="{ 'invalid': errors.has('EmployeeCode') }"
                                        >
                                    <span class="form-message">{{ errors.first('EmployeeCode') }}</span>
                                </div>
                                <div class="form-group width-60">
                                    <label class="control-label">Tên <span style="color: red;">*</span></label>
                                    <input class="form-control" name="EmployeeName"
                                        spellcheck="false"
                                        v-model="Employee.employeeName" ref="EmployeeName"
                                        v-validate="'required|max:100'"
                                        :class="{ 'invalid': errors.has('EmployeeName') }"
                                        >
                                    <span class="form-message">{{ errors.first('EmployeeName') }}</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group width-100">
                                    <label class="control-label">Đơn vị <span style="color: red;">*</span></label>
                                    <multiselect
                                        class="form-control" 
                                        @input="opt => Employee.departmentId = opt.departmentId"
                                        v-model="Department" ref="Department"
                                        :options="select.departmentOptions"
                                        :searchable="true"
                                        :placeholder="'Chọn đơn vị'"
                                        label="departmentName"
                                        :show-labels="false"
                                        v-validate="{required: true}"
                                        name="Department"
                                        :class="{ 'invalid': errors.has('Department') }"
                                        @close="$validator.validate()">
                                        <span slot="noOptions">Không có đơn vị để hiển thị</span>
                                        <span slot="noResult">Không có đơn vị phù hợp</span>
                                    </multiselect>
                                    <span class="form-message">{{ errors.first('Department') }}</span>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group width-100">
                                    <label class="control-label">Chức danh</label>
                                    <input class="form-control" name="EmployeePosition"
                                        spellcheck="false"
                                        v-model="Employee.employeePosition" ref="EmployeePosition"
                                        v-validate="'max:255'"
                                        :class="{ 'invalid': errors.has('EmployeePosition') }"
                                        >
                                    <span class="form-message">{{ errors.first('EmployeePosition') }}</span>
                                </div>
                            </div>
                        </div>
                        <div class="col">
                            <div class="row">
                                <div class="form-group width-40">
                                    <label class="control-label">Ngày sinh</label>
                                    <date-picker class="form-control" name="DateOfBirth"
                                        v-model="Employee.dateOfBirth" value-type="YYYY-MM-DD"
                                        format="DD/MM/YYYY" placeholder="DD/MM/YYYY"
                                        :disabled-date="(date)=> date>new Date()"
                                        lang="vi" ></date-picker>
                                </div>
                                <div class="form-group width-60">
                                    <label class="control-label">Giới tính</label>
                                    <div class="form-control d-flex gender-space">
                                        <radio-box label="Nam" :value="1" v-model="Employee.gender"/>
                                        <radio-box label="Nữ" :value="0" v-model="Employee.gender"/>
                                        <radio-box label="Khác" :value="2" v-model="Employee.gender"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group width-60">
                                    <label class="control-label">Số CMND</label>
                                    <input class="form-control" name="IdentityNumber"
                                        spellcheck="false"
                                        v-model="Employee.identityNumber" ref="IdentityNumber"
                                        v-validate="{
                                            //regex: /^\d{9}$|^\d{12}$/
                                        }"
                                        :class="{ 'invalid': errors.has('IdentityNumber') }"
                                        >
                                    <span class="form-message">{{ errors.first('IdentityNumber') }}</span>
                                </div>
                                <div class="form-group width-40">
                                    <label class="control-label">Ngày cấp</label>
                                    <div>
                                        <date-picker class="form-control" name="IdentityDate"
                                            v-model="Employee.identityDate" value-type="YYYY-MM-DD"
                                            format="DD/MM/YYYY" placeholder="DD/MM/YYYY"
                                            :disabled-date="(date)=> date>new Date()"
                                            lang="vi"></date-picker>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group width-100">
                                    <label class="control-label">Nơi cấp</label>
                                    <input class="form-control"  name="IdentityPlace"
                                        spellcheck="false"
                                        v-model="Employee.identityPlace" ref="IdentityPlace"
                                        v-validate="'max:255'"
                                        :class="{ 'invalid': errors.has('IdentityPlace') }">
                                    <span class="form-message">{{ errors.first('IdentityPlace') }}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group width-100">
                            <label class="control-label">Địa chỉ</label>
                            <input class="form-control" name="Address"
                                spellcheck="false"
                                v-model="Employee.address" ref="Address"
                                v-validate="'max:255'"
                                :class="{ 'invalid': errors.has('Address') }">
                            <span class="form-message">{{ errors.first('Address') }}</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group width-25">
                            <label class="control-label">ĐT di động</label>
                            <div>
                                <input class="form-control" name="PhoneNumber"
                                    spellcheck="false"
                                    v-model="Employee.phoneNumber" ref="PhoneNumber"
                                    v-validate="{
                                        //regex: /^\d+$/,
                                        max: 20,
                                    }"
                                    :class="{ 'invalid': errors.has('PhoneNumber') }"
                                    >
                                <span class="form-message">{{ errors.first('PhoneNumber') }}</span>
                            </div>
                        </div>
                        <div class="form-group width-25">
                            <label class="control-label">ĐT cố định</label>
                            <div>
                                <input class="form-control" name="TelephoneNumber" 
                                    spellcheck="false"
                                    v-model="Employee.telephoneNumber" ref="TelephoneNumber"
                                    v-validate="{
                                        //regex: /[\d+()-]+/,
                                        max: 20,
                                    }"
                                    :class="{ 'invalid': errors.has('TelephoneNumber') }"
                                    >
                                <span class="form-message">{{ errors.first('TelephoneNumber') }}</span>
                            </div>
                        </div>
                        <div class="form-group width-25">
                            <label class="control-label">Email</label>
                                <input type="text" class="form-control" name="Email"
                                    spellcheck="false"
                                    v-model="Employee.email" ref="Email"
                                    v-validate="{
                                        //regex: /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/,
                                        max: 50,
                                    }"
                                    :class="{ 'invalid': errors.has('Email') }"
                                    >
                                <span class="form-message">{{ errors.first('Email') }}</span>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group width-25">
                            <label class="control-label">Tài khoản ngân hàng</label>
                            <input class="form-control" name="BankAccountNumber"
                                spellcheck="false"
                                v-model="Employee.bankAccountNumber" ref="BankAccountNumber"
                                v-validate="{
                                    //regex: /^\d+$/,
                                    max: 20,
                                }"
                                :class="{ 'invalid': errors.has('BankAccountNumber') }"
                                >
                            <span class="form-message">{{ errors.first('BankAccountNumber') }}</span>
                        </div>
                        <div class="form-group width-25">
                            <label class="control-label">Tên ngân hàng</label>
                            <input class="form-control" name="BankName"
                                spellcheck="false"
                                v-model="Employee.bankName" ref="BankName"
                                v-validate="'max:255'"
                                :class="{ 'invalid': errors.has('BankName') }">
                            <span class="form-message">{{ errors.first('BankName') }}</span>
                        </div>
                        <div class="form-group width-25">
                            <label class="control-label">Chi nhánh</label>
                            <input class="form-control" name="BankBranchName"
                                spellcheck="false"
                                v-model="Employee.bankBranchName" ref="BankBranchName"
                                v-validate="'max:255'"
                                :class="{ 'invalid': errors.has('BankBranchName') }">
                            <span class="form-message">{{ errors.first('BankBranchName') }}</span>
                        </div>
                    </div>
                </form>
            </div>
            <!-- phần cuối -->
            <div class="modal-footer d-flex">
                <button type="button" class="btn btn-secondary" v-tooltip="'Đóng hộp thoại'"
                    @click="$emit('close')" >Hủy</button>
                <div class="d-flex">
                    <button type="button" class="btn btn-secondary" v-tooltip="'Cất(Ctrl+M)'"
                        @click="wannaClose=true; saveEmployee();">Cất</button>
                    <button type="button" class="btn btn-primary btn-save"  v-tooltip="'Cất và thêm'"
                        @click="wannaClose=false; saveEmployee();">
                        Cất và thêm
                    </button>
                </div>
            </div>
        </vue-resizable>
    </div>
    <!-- đặt chỗ cho popup-->
    <pop-up v-if="popup.popupStatus" :modal="popup.modal" @close="closePopUp()"/>
</div>
</template>

<script>
// date picker
import DatePicker from 'vue2-datepicker'
import 'vue2-datepicker/locale/vi'
import 'vue2-datepicker/index.css'
// vue-resizable
import VueResizable from "vue-resizable"
// vue-multiselect
import Multiselect from 'vue-multiselect'
// common
import Resource from '../../../js/common/Resource.js'
import Enum from '../../../js/common/Enum.js'
//api
import apiEmployee from '../../../js/api/EmployeeAPI'
import apiDepartment from '../../../js/api/DepartmentAPI'
// component
import RadioBox from '../../base/RadioButton.vue'
import PopUp from '../../base/PopUp.vue'

export default {
    name: 'EmployeeDialog',
    props: ['employeeId', 'initialFormMode'],
    components:{
        DatePicker,
        PopUp,
        VueResizable,
        Multiselect,
        RadioBox,
    },
    data(){
        return {
            // nhân viên
            Employee:{
                employeeCode: null,
                gender: null,
            },
            // json nhân viên ban đầu để so sánh thay đổi
            originalEmployee: null,
            // phòng ban do multi select k có map one value
            Department: null,
            // xem là cất xong có đóng k
            wannaClose: null,
            // formMode riêng khác lúc khởi tạo
            formMode: null,
            // popup
            popup:{
                popupStatus: false,
                modal:{},
            },
            // làm cho form có thể drag
            resizable:{
                draggable: '.modal-header, .modal-footer',
                handlers: [],
            },
            // quản lí các select
            select: {
                departmentOptions: [],
            },
            // quản lí validation
            validation:{
                dict:{
                    custom: Resource.ValidateDict,
                },
            },
        }
    },
    methods:{
        initDialog(responses) {
            let me = this;
            // luôn lấy danh sách đơn vị
            me.select.departmentOptions=responses[0].data.data

            if(me.employeeId) {
                if(me.formMode==Resource.FormMode.Duplicate)
                    me.Employee=responses[2].data.data
                // nếu là edit thì là response số 2 do k gọi new employee code
                if(me.formMode==Resource.FormMode.Edit)
                    me.Employee=responses[1].data.data

                //bind thông tin ngày tháng
                me.Employee.dateOfBirth=me.formatDate(me.Employee.dateOfBirth)
                me.Employee.identityDate=me.formatDate(me.Employee.identityDate)
                // bind đơn vị nếu có
                if(me.Employee.departmentId) {
                    me.Department=me.select.departmentOptions.filter(item => item.departmentId==(me.Employee.departmentId))[0]
                }
            }
            else if(me.formMode == Resource.FormMode.Edit || me.formMode == Resource.FormMode.Duplicate){
                me.errorPopUp();
            }
            
            // nếu cần lấy mã thì response thứ 2 là mã mới
            if(me.formMode == Resource.FormMode.Add || me.formMode == Resource.FormMode.Duplicate)
                me.Employee.employeeCode=responses[1].data.data;

            // sau tất cả, lưu trạng thái đầu của nhân viên
            me.originalEmployee=JSON.stringify(me.Employee)
        },
        /**
         * đóng dialog
         * Author: CpNam 17.07.2021
         */
        close(){
            let me=this;
            if (JSON.stringify(me.Employee) != me.originalEmployee)
                me.openPopUp({
                    message: `Dữ liệu đã bị thay đổi. Bạn có muốn cất không?`,
                    cancelText: 'Hủy',
                    noText: 'Không',
                    continueText: 'Có',
                    modalMode: Resource.PopUpMode.Question,
                    callbackNoFunc: ()=>{
                        me.$emit('close');
                    },
                    callbackOkFunc: ()=>{
                        me.wannaClose = true;
                        me.saveEmployee();
                    }
                });
            else me.$emit('close');
        },
        /**
         * lưu nhân viên, tùy vào formmode mà thêm hoặc sửa
         * Author: CpNam 17.07.2021
         */
        saveEmployee(){
            let me = this;
            // nếu gender k rỗng thì đổi về number vì khs nó lại bị thành string dù model của nó là number
            if(me.Employee.gender) me.Employee.gender = Number(me.Employee.gender);

            // validate không có lỗi thì sub
            me.$validator.validate().then(valid => {
                // có lỗi thì lấy lỗi
                if (!valid) {
                    me.openPopUp({
                        message: me.errors.items[0].msg,
                        modalMode: Resource.PopUpMode.Error,
                        continueText: "Đồng ý",
                        callbackOkFunc: ()=>{
                            if(me.errors.items[0].field == "Department") 
                                me.$refs[me.errors.items[0].field].$el.focus();
                            else me.$refs[me.errors.items[0].field].focus();
                        }
                    });
                }
                else{
                    // nếu là thêm hoặc nhân bản thì thêm
                    if(me.formMode == Resource.FormMode.Add || me.formMode == Resource.FormMode.Duplicate){
                        me.addEmployee();
                    }
                    // nếu là sửa thì thực hiện sửa
                    else if(me.formMode == Resource.FormMode.Edit){
                        me.editEmployee();
                    }
                }
            });
        },
        focusCustom(field){
            let me = this;

            if(field == "Department") 
                me.$refs[field].$el.focus();
            else me.$refs[field].focus();
        },
        addEmployee(){
            let me = this;

            apiEmployee.addEmployee(me.Employee)
            .then((response)=>{
                // dữ liệu không hợp ý server
                if(response.data.misaCode == Enum.MISACode.Invalid){
                    me.openPopUp({
                        message: response.data.messenger,
                        continueText: 'Đồng ý',
                        modalMode: Resource.PopUpMode.Warning,
                        callbackOkFunc: () => me.focusCustom(response.data.data)
                    });
                }
                else{
                    // thêm thành công nên gửi toast
                    me.$emit('success', 'Thêm nhân viên thành công', Resource.ToastMesengerMode.Success);
                    // nếu bấm cất thì muốn đóng, nếu bấm cất và thêm thì k đóng
                    if(me.wannaClose) me.$emit('close');
                    else me.clearForm();
                }
            })
            .catch((response)=>{
                console.log(response, "");
                me.errorPopUp();
            });
        },
        editEmployee(){
            let me = this;

            apiEmployee.editEmployee(me.employeeId, me.Employee)
            .then((response)=>{
                // dữ liệu không hợp ý server
                if(response.data.misaCode == Enum.MISACode.Invalid){
                    me.openPopUp({
                        message: response.data.messenger,
                        continueText: 'Đồng ý',
                        modalMode: Resource.PopUpMode.Warning,
                        callbackOkFunc: () => me.focusCustom(response.data.data)
                    });
                }
                else{
                    // sửa thành công nên gửi toast
                    me.$emit('success', 'Sửa nhân viên thành công', Resource.ToastMesengerMode.Success);
                    // nếu bấm cất thì muốn đóng, nếu bấm cất và thêm thì k đóng
                    if(me.wannaClose) me.$emit('close');
                    else me.clearForm();
                }
            })
            .catch((res)=>{
                console.log(res, "");
                me.errorPopUp();
            });
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
        errorPopUp(){
            this.openPopUp({
                message: 'Có lỗi xảy ra. Vui lòng thử lại sau.',
                continueText: 'Đóng',
                modalMode: Resource.PopUpMode.Error,
                callbackOkFunc: ()=>{
                    this.$emit('close')
                }
            });
        },
        /**
         * format date when binding
         * Author: CpNam 17.07.2021
         */
        formatDate(value){
            if(value == null) return value;
            let tmp = new Date(value);
            // định dạng yyyy/mm/dd
            return (tmp.getFullYear() + '-' + String(tmp.getMonth()+1).padStart(2, '0') + '-'+ String(tmp.getDate()).padStart(2, '0'));
        },
        /**
         * làm mới form
         * Author: CpNam 19.08.2021
         */
        clearForm(){
            let me=this;
            // đặt lại vue multi select
            me.Department = null;
            // đặt nhân viên về trạng thái đầu
            me.Employee = {
                employeeCode: null,
                gender: null,
            };
            // đặt lại form mode dù sẽ k tốt lắm
            me.formMode = Resource.FormMode.Add;
            // lấy mã mới
            apiEmployee.getNewCode()
                .then((response)=>{
                    me.Employee.employeeCode = response.data.data;
                    // sau khi có mã mới thì đặt lại nhân viên ban đầu để so sánh
                    me.originalEmployee = JSON.stringify(me.Employee);
                })
                .catch(()=>{
                    me.errorPopUp();
                })
            // focus vào ô đầu tiên
            me.$refs.EmployeeCode.focus();
        },
    },
    created(){
        let me = this;
        me.formMode = me.initialFormMode;

        // danh sách những api cần gọi đồng thời nên cho vào mảng
        let promises = [apiDepartment.getDepartments()];

        // nếu là thêm hoặc nhân bản thì cần lấy mã mới
        if(me.formMode == Resource.FormMode.Add || me.formMode == Resource.FormMode.Duplicate){
            promises.push(apiEmployee.getNewCode());
        }

        // nếu là sửa hoặc nhân bản thì cần lấy thông tin nhân viên
        if(me.formMode == Resource.FormMode.Edit || me.formMode == Resource.FormMode.Duplicate){
            if(me.employeeId) promises.push(apiEmployee.getEmployee(me.employeeId));
        }
        
        // chờ tất cả api xử lí xong
        Promise.all(promises)
        .then((responses)=>{
            me.initDialog(responses);
        })
        .catch(()=>{
            me.errorPopUp();
        });
    },
    mounted(){
        let me=this;
        // focus vào ô đầu tiên
        me.$nextTick(()=>{
            me.$refs.EmployeeCode.focus();
        })
        // khởi tạo vaidator
        me.$validator.localize('vi', me.validation.dict);
    }
}
</script>

<style scoped>
    @import url('../../../css/common/multiselect.css');
    @import url('../../../css/common/dialog.css');
    @import url('../../../css/common/formdialog.css');
</style>
