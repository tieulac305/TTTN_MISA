<template>
    <div class="detail-view pnl-content">
        <!-- thanh lọc, tìm kiếm -->
        <div class="filter-bar d-flex">
            <!-- xóa nhiều -->
            <div>
                <div style="display: flex; align-items: center;"
                    v-show="grid.selectedList.length > 1">
                    <div class="icon delete-icon"
                        @click="deleteSelection()"
                        v-tooltip.bottom="'Xóa nhân viên đã chọn'">
                    </div>
                    <div class="icon export-selected-icon"
                        v-tooltip.bottom="'Xuất Excel nhân viên đã chọn'"
                        @click="exportSelection()"></div>
                </div>
            </div>
            <div style="display: flex; align-items: center;">
                <!-- ô tìm kiếm -->
                <div class="search-group">
                    <input type="seacrh" name="searchtext" v-model="filter.text" class="text-filter" placeholder="Tìm kiếm theo mã, tên, SĐT nhân viên"
                        @input="waitForSearch();"
                        v-tooltip.bottom="'Nhập để tìm kiếm'">
                    <span class="icon search-icon"></span>
                </div>
                <!-- icon refresh -->
                <div class="icon refresh-icon"
                    v-tooltip.bottom="'Làm mới dữ liệu'"
                    @click="refresh()"></div>
                <!-- icon import -->
                <div class="icon import-icon"
                    v-tooltip.bottom="'Nhập từ tệp Excel'"
                    @click="importMultiple()"></div>
                <!-- icon export -->
                <div class="icon export-icon"
                    v-tooltip.bottom="'Tải xuống tệp Excel'"
                    @click="exportAll()"></div>
            </div>
        </div>
        <!-- bảng chính -->
        <div class="gridview">
            <table>
                <thead>
                    <tr>
                        <!-- checkbox tiêu đề -->
                        <th id="check-all"  class="text-center employee-checkbox">
                            <label class="checkbox-wrapper flex items-center">
                                <input class="checkbox" type="checkbox"
                                    ref="checkboxAll"/>
                                <span class="checkmark"
                                    @click="checkAll();"></span>
                            </label>
                        </th>
                        <!-- các cột -->
                        <th v-for="col in columns" 
                            :key="col.fieldName"
                            :id="col.fieldName"
                            :class="getClass(col.dataType)">
                            {{col.headerText}}
                        </th>
                        <!-- cột chức năng -->
                        <th class="action" id="action-header">Chức năng</th>
                    </tr>
                </thead>
                <tbody v-show="!grid.isLoading">
                    <tr v-for="item in grid.data" :key="item.employeeId"
                        :class="{selected: grid.selectedList.includes(item)}"
                        @click="rowClick(item);">
                        <!-- ô checkbox -->
                        <td class="employee-checkbox">
                            <label class="checkbox-wrapper flex items-center">
                                <input class="checkbox" type="checkbox"
                                    :checked="grid.selectedList.includes(item)"/>
                                <span class="checkmark"
                                    @click.stop.prevent="checkboxClick(item)"></span>
                            </label>
                        </td>
                        <!-- các ô thông tin -->
                        <td v-for="col in columns" :key="col.fieldName" :class="getClass(col.dataType)">{{ formatData(item[col.fieldName],col.dataType) }}</td>
                        
                        <!-- ô hành động -->
                        <td class="action">
                            <button class="btn btn-text" @click.stop="editClick(item.employeeId)">Sửa</button>
                            <label class="icon triangle-blue-icon"
                                    @click.stop="(event)=>{ menu.status = menu.employee == null || (menu.employee.employeeId == item.employeeId ? !menu.status : true);
                                        menu.employee = item; calculatePosition(event);}"></label>
                        </td>
                    </tr>
                </tbody>
            </table>
            <!-- menu nhân bản, xóa -->
            <div class="context-menu" v-show="menu.status" :style="{top: menu.positionY+'px'}">
                <label class="context-menu-item" @click="duplicateClick(menu.employee.employeeId)">Nhân bản</label>
                <label class="context-menu-item" @click="deleteClick(menu.employee)">Xóa</label>
                <label class="context-menu-item" @click="exportData([menu.employee])">Lưu tệp Excel</label>
            </div>
            <!-- khi đang tải -->
            <div class="loading-container" v-show="grid.isLoading">
                <div class="loading-row">
                    <div class="loading-content"></div>
                </div>
                <div class="loading-row">
                    <div class="loading-content"></div>
                </div>
                <div class="loading-row">
                    <div class="loading-content"></div>
                </div>
                <div class="loading-row">
                    <div class="loading-content"></div>
                </div>
                <div class="loading-row">
                    <div class="loading-content"></div>
                </div>
                <div class="loading-row">
                    <div class="loading-content"></div>
                </div>
                <div class="loading-row">
                    <div class="loading-content"></div>
                </div>
            </div>
            <!-- khi không có bản ghi -->
            <div class="no-record" v-show="!grid.isLoading && grid.totalRecords == 0">Không có dữ liệu</div>
        </div>
        <!-- phân trang -->
        <pagination
            v-show="grid.totalRecords > 0"
            :total="grid.totalRecords"
            :total-pages="grid.totalPages"
            :per-page="paging.pageSize"
            :current-page="paging.pageIndex"
            :max-visible-buttons="paging.maxVisibleButtons"
            @page-change="onPageChange"
            @size-change="onPageSizeChange"/>
        <!-- chỗ cho popup -->
        <pop-up v-if="popup.status" :modal="popup.modal" @close="closePopUp()"/>
    </div>
</template>

<script>
import writeXlsxFile from 'write-excel-file'
import Resource from '../../../js/common/Resource'
import PopUp from '../../base/PopUp.vue'
import Pagination from '../../base/Pagination.vue'
import apiEmployee from '../../../js/api/EmployeeAPI'

export default {
    name:'EmployeeGrid',
    components:{
        PopUp,
        Pagination,
    },
    data(){
        /**
         * khởi tạo các thông tin sẽ xuất hiện trong bảng
         * Author: CpNam 17.07.2021
         */
        return{
            // danh sách nhân viên
            grid:{
                data: null,
                totalRecords: 0,
                totalPages: 0,
                selectedList: [],
                isLoading: false,
            },
            // pop-up
            popup:{
                status: false,
                modal:{},
            },
            columns: Resource.Schema.EmployeeTable,
            // context menu hiển thị của ai
            menu: {
                employee: null,
                status: false,
                positionY: 0
            },
            // lọc
            filter:{
                text: '',
                thePromise: null
            },
            // phân trang
            paging:{
                pageIndex: 1,
                pageSize: 20,
                maxVisibleButtons: 3,
            },
        }
    },
    methods:{
        /**
         * mở popup
         * @param {thông tin popup} modal
         * Author: CpNam 17.07.2021
         */
        openPopUp(modal){
            this.popup.modal = modal;
            this.popup.status = true;
        },
        /**
         * đóng popup
         * Author: CpNam 17.07.2021
         */
        closePopUp(){
            this.popup.status = false;
        },
        /**
         * mở toast
         * Author: CpNam 05.10.2021
         */
        openToast(msg, mode){
            this.$emit('toast', msg, mode);
        },
        /**
         * lấy ra class của định dạng type
         * @param {kiểu dữ liệu} type
         * @returns tên lớp tương ứng
         * Author: CpNam 17.07.2021
         */
        getClass(type){
            if(!type) return 'text-left';
            let className = '';
            if(type == 'Number' || type == 'Money'){
                className = 'text-right';
            }
            else if(type == 'String' || type == 'Date'){
                className = 'text-center';
            }
            return className;
        },
        /**
         * định dạng dữ liệu theo kiểu
         * @param {dữ liệu} data
         * @param {kiểu} type
         * @returns dữ liệu đã qua định dạng
         * Author: CpNam 17.07.2021
         */
        formatData(data, type){
            let result = data;

            if(type == ''){
                result = data;
            }
            else if(type == 'Date'){
                if(data==null) return data;
                var tmp = new Date(data);
                // định dạng: dd/mm/yyyy
                result = String(tmp.getDate()).padStart(2, '0') + '/' 
                    + String(tmp.getMonth()+1).padStart(2, '0') + '/' + tmp.getFullYear();
            }

            return result;
        },
        /**
         * lấy ra nhân viên cho grid
         * Author: CpNam 17.07.2021
         */
        getEmployees(){
            // trước khi tải thì xóa những phần đã chọn
            this.clearSelectedList();

            let me=this;
            if(!me.grid.isLoading){
                me.grid.isLoading = true;
                setTimeout(
                    ()=>apiEmployee.getEmployeeFilterPaging(me.paging.pageIndex, me.paging.pageSize, me.filter.text)
                        .then((res)=>{
                            me.grid.data = res.data.data.list;
                            me.grid.totalPages = res.data.data.totalPage;
                            me.grid.totalRecords = res.data.data.totalRecord;
                            me.grid.isLoading = false;
                        })
                        .catch(()=>{
                            this.openPopUp({
                                message: Resource.Message.Exception,
                                cancelText: 'Đóng',
                                continueText: 'Tải lại',
                                modalMode: Resource.PopUpMode.Error,
                                callbackOkFunc: () => location.reload()
                            })
                            me.grid.isLoading = false;
                        })
                ,1000)
            }
        },
        /**
         * tải lại dữ liệu
         * Author: CpNam 20.07.2021
         */
        refresh(){
            // về trang 1
            this.paging.pageIndex = 1;
            // xóa tìm kiếm
            this.filter.text = '';
            // tải lại dữ liệu
            this.getEmployees();
        },
        /**
         * khi đổi page
         * Author: CpNam 25.07.2021
         */
        onPageChange(page){
            // xóa bỏ những gì đã chọn
            this.clearSelectedList();

            this.paging.pageIndex = page;
            // tải lại theo số liệu mới
            this.getEmployees();
        },
        /**
         * khi đổi kích thước trang
         */
        onPageSizeChange(size){
            // xóa bỏ những gì đã chọn
            this.clearSelectedList();

            this.paging.pageSize = size;
            // tải lại theo số liệu mới
            this.getEmployees();
        },
        clearSelectedList(){
            while(this.grid.selectedList.length>0) this.grid.selectedList.pop();
            // xóa ô checkbox all nếu có
            if(this.$refs.checkboxAll) this.$refs.checkboxAll.checked = false;
        },
        rowClick(employee){
            this.clearSelectedList();
            this.grid.selectedList.push(employee);
            // chỉnh ô checkbox all
            this.$refs.checkboxAll.checked = (this.grid.selectedList.length == this.grid.data.length);
        },
        checkboxClick(employee){
            if(this.grid.selectedList.includes(employee)){
                this.grid.selectedList.splice(this.grid.selectedList.indexOf(employee),1);
            }
            else{
                this.grid.selectedList.push(employee);
            }
            // chỉnh ô checkbox all
            this.$refs.checkboxAll.checked = (this.grid.selectedList.length == this.grid.data.length);
        },
        /**
         * chọn tất cả
         * Author: CpNam 18.08.2021
         */
        checkAll(){
            let selectedLength = this.grid.selectedList.length;
            // clear selected
            this.clearSelectedList();
            this.$refs.checkboxAll.checked = true;
            // if size is different
            if(selectedLength != this.grid.data.length){
                // clone list to selected
                for(var i = 0, len = this.grid.data.length; i < len; ++i)
                    this.grid.selectedList.push(this.grid.data[i]);
                this.$refs.checkboxAll.checked = false;
            }
        },
        /**
         * tính vị trí của context menu
         * Author: 22.08.2021
         */
        calculatePosition(event){
            let me = this;

            me.menu.positionY=event.clientY-event.offsetY+20;
            if(window.innerHeight < me.menu.positionY + 120){
                me.menu.positionY -= 120;
            }
        },
        /**
         * yêu cầu sửa một nhan viên
         * Author: CpNam 20.08.2021
         */
        editClick(id){
            this.$emit('edit', id);
        },
        /**
         * yêu cầu nhân bản một nhân viên
         * Author: CpNam 20.08.2021
         */
        duplicateClick(id){
            this.$emit('duplicate', id);
        },
        /**
         * yêu cầu xóa một nhân viên
         * Author: CpNam 20.08.2021
         */
        deleteClick(employee){
            // build messge
            let message = `Bạn có thực sự muốn xóa nhân viên &lt; ` + employee.employeeCode + ` &gt; không?`;
            let me=this;
            me.openPopUp({
                message: message,
                cancelText: 'Không',
                continueText: 'Có',
                modalMode: Resource.PopUpMode.Warning,
                callbackOkFunc: ()=>{
                    apiEmployee.deleteEmployee(employee.employeeId)
                    .then(()=>{
                        me.openToast("Xóa thành công!", Resource.ToastMesengerMode.Success);
                        me.refresh();
                    })
                    .catch(()=>{
                        me.openToast("Không thể xóa nhân viên.", Resource.ToastMesengerMode.Info);
                    });
                },
            })
        },
        /**
         * chờ để được tìm kiếm
         * Author: CpNam 09.08.2021
         */
        waitForSearch(){
            let me = this;
            clearTimeout(me.filter.thePromise);
            me.filter.thePromise = setTimeout(function(){
                me.paging.pageIndex = 1;
                me.getEmployees();
            },1000);
        },
        /**
         * Xóa những nhân viên đang chọn
         * Author: CpNam 05.10.2021
         */
        deleteSelection(){
            let me = this;
            // build messge
            let codeList = me.grid.selectedList.slice(0,3).map((item)=>item.employeeCode).join(', ');
            if (me.grid.selectedList.length > 3)
                codeList += ` và ${me.grid.selectedList.length-3} người khác`;
            let message = `Bạn có thực sự muốn xóa nhân viên &lt; ` + codeList + ` &gt; không?`;
            me.openPopUp({
                message: message,
                cancelText: 'Không',
                continueText: 'Có',
                modalMode: Resource.PopUpMode.Warning,
                callbackOkFunc: ()=>{
                    // build list
                    let listId = me.grid.selectedList.map((item)=>item.employeeId);
                    apiEmployee.deleteMultiple(listId)
                    .then(()=>{
                        me.openToast("Xóa thành công.", Resource.ToastMesengerMode.Success);
                        me.refresh();
                    })
                    .catch(()=>{
                        me.openToast(Resource.Message.Exception, Resource.ToastMesengerMode.Info);
                    });
                },
            });
        },
        /**
         * hàm xuất file excel
         * Author: CpNam 05.10.2021
         */
        exportData(data){
            let me = this,
                objects = data,
                schema = Resource.Schema.EmployeeExport;
            writeXlsxFile(objects, {
                schema,
                headerStyle: {
                    backgroundColor: '#f5e5e5',
                    fontWeight: 'bold',
                    borderColor: '#000000',
                    align: 'center'
                },
                fontFamily: 'Arial',
                fontSize: 13,
                fileName: 'employees.xlsx'
            })
            .then(() => me.openToast('Xuất bản tệp thành công!', Resource.ToastMesengerMode.Success))
            .catch(() => me.openToast(Resource.Message.Exception, Resource.ToastMesengerMode.Info));
        },
        /**
         * xuất ra những nhân viên đang chọn
         * Author: CpNam 05.10.2021
         */
        exportSelection(){
            this.exportData(this.grid.selectedList);
            this.clearSelectedList();
        },
        /**
         * xuất tất cả dữ liệu nhân viên
         * Author: CpNam 05.10.2021
         */
        exportAll(){
            let me = this;
            // gọi api lấy tất cả về để xuất
            apiEmployee.getEmployees()
            .then((res)=>{
                me.exportData(res.data.data);
            })
            .catch(()=>{
                me.openToast(Resource.Message.Exception, Resource.ToastMesengerMode.Info)
            });
        },
        /**
         * cho phép thêm nhiều từ file
         */
        importMultiple(){
            this.$emit('import');
        }
    },
    created(){
        // lấy sự kiện refresh từ cha
        this.$parent.$on('refresh', ()=>this.refresh());
    },
    mounted(){
        // thêm sự kiện click thì đóng menu popup
        window.addEventListener('click', ()=>{
            this.menu.status=false;
        });
        // lấy nhân viên
        this.getEmployees();
    },
    destroy(){
        window.removeEventListener('click');
    }
}
</script>

<style scoped>
    @import url('../../../css/common/gridview.css');
</style>