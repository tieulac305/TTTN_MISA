<template>
  <div>
    <!-- thanh tiêu đề, hành động -->
    <div class="title-action-bar">
      <div class="title">Nhân viên</div>
      <div class="action" id="actionEmployee">
        <button class="btn btn-primary btn-add" @click="openDialog('Add')" v-tooltip="'Mở hộp thoại thêm'">
          Thêm mới nhân viên
        </button>
      </div>
    </div>
    
    <!-- grid và loading cho grid -->
    <employee-grid
      @edit="editEmployee"
      @duplicate="duplicateEmployee"
      @import="openImportDialog"
      @toast="openToast"/>
    <!-- popup thông tin chi tiết nhân viên -->
    <employee-dialog
      v-if="dialog.status"
      :initial-form-mode="dialog.mode"
      :employee-id="dialog.employeeId"
      @success="openToast"
      @close="closeDialog"/>
    <!-- popup import -->
    <import-dialog
      v-if="importDialog.status"
      @close="closeImportDialog"
      @toast="openToast"/>
    <!-- đặt chỗ cho toast -->
    <toast-messenger v-if="toast.status" :message="toast.message" 
      :toast-mode="toast.mode" @close="closeToast()"/>
  </div>
</template>

<script>
// chung
import Resource from '../../../js/common/Resource'
import ToastMessenger from '../../base/ToastMessenger.vue'
// riêng
import EmployeeGrid from './EmployeeGrid.vue'
import EmployeeDialog from './EmployeeDialog.vue'
import ImportDialog from './ImportDialog.vue'

export default {
  name: 'Employee',
  components:{
    ToastMessenger,
    EmployeeGrid,
    EmployeeDialog,
    ImportDialog
  },
  data(){
    return{
      // hộp thoại chi tiết nhân viên
      dialog: {
        status: false,
        mode: null,
        employeeId: null
      },
      toast: {
        status: false,
        message: '',
        mode: '',
      },
      importDialog: {
        status: false,
      }
    }
  },
  methods:{
    /**
     * mở ra hộp thoại chi tiết nhân viên
     * Author: CpNam 17.07.2021
     */
    openDialog(mode, id=null){
      this.dialog.status = true;
      this.dialog.mode = mode;
      // nếu mode là sửa hoặc nhân bản thì bind selected emp vào để lấy thông tin
      if(mode == Resource.FormMode.Edit || mode == Resource.FormMode.Duplicate){
        this.dialog.employeeId = id;
      }
    },
    /**
     * đóng hộp thoại chi tiết nhân viên
     * Author: CpNam 17.07.2021
     */
    closeDialog(){
      this.dialog.status = false;
      this.$emit('refresh');
    },
    /**
     * sửa nhân viên, mở dialog sửa
     * Author: CpNam 19.08.2021
     */
    editEmployee(id){
      this.openDialog(Resource.FormMode.Edit, id);
    },
    /**
     * nhân bản thông tin nhân viên
     * Author: CpNam 19.08.2021
     */
    duplicateEmployee(id){
      this.openDialog(Resource.FormMode.Duplicate, id);
    },
    /**
     * mở toast
     * @param {String} message thông tin
     * @param {*} mode kiểu
     * Author: CpNam 17.07.2021
     */
    openToast(message, mode){
      this.toast.message = message;
      this.toast.mode = mode;
      this.toast.status = true;
    },
    /**
     * đóng toast
     * Author: CpNam 17.07.2021
     */
    closeToast(){
      this.toast.status = false;
    },
    openImportDialog(){
      this.importDialog.status = true;
    },
    closeImportDialog(){
      this.importDialog.status = false;
      this.$emit('refresh');
    },
  }
}
</script>

<style scoped>
  @import url('../../../css/view/employee.css');
</style>
