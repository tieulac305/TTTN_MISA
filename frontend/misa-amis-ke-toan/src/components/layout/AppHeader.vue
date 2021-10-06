<template>
    <div class="header">
        <div class="left">
            <div class="icon toggle-icon"  v-on:click="changeSidebarSize" v-tooltip.bottom="'Thu gọn menu'"></div>
            <div class="branch-select">
                CÔNG TY CỔ PHẦN MISA
            </div>
            <div class="arrow-down-icon icon" v-tooltip.bottom="'Chọn chi nhánh'"></div>
        </div>
        <!-- phần của user -->
        <div class="user-nav">
            <div class="icon notif-icon" v-tooltip.bottom="'Thông báo'"></div>
            <div class="user-info">
                <img class="user-avatar" src="../../assets/img/default-avatar.jpg" alt="avatar">
                <div class="user-fullname">Chu Dương Phương Nam</div>
            </div>
            <div class="arrow-down-icon icon more-icon"  v-tooltip.bottom="'Thêm hành động'" tabindex=0></div>
        </div>
    </div>
</template>

<script>
export default {
  name: 'AppHeader',
  methods:{
    /**
     * yêu cầu thay đổi kích thước navbar
     * Author: CpNam 19.08.2021
     */
    changeSidebarSize(){
        this.$emit('change-sidebar-size');
    }
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
    @import url('../../css/common/header.css');
</style>