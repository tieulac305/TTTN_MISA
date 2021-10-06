<template>
    <div class="sidebar">
        <!-- logo -->
        <div class="logo-box">
            <div class="icon option-icon"
                @click="$emit('change-sidebar-size');"></div>
            <img class="logo-icon" src="../../assets/img/logo.svg" alt="logo">
        </div>
        <!-- các danh mục -->
        <div class="navbar">
            <div class="nav-item" v-tooltip="'Tổng quan'">
                <div class="icon dashboard-icon"></div>
                <div class="nav-item-text">Tổng quan</div>
            </div>
            <router-link to="/employee" class="nav-item">
                <div class="icon employee-icon" v-tooltip="'Danh mục nhân viên'"></div>
                <div class="nav-item-text">Danh mục nhân viên</div>
            </router-link>
            <div class="nav-item">
                <div class="icon cash-icon" v-tooltip="'Tiền mặt'"></div>
                <div class="nav-item-text">Tiền mặt</div>
            </div>
            <div class="nav-item">
                <div class="icon bank-icon" v-tooltip="'Tiền gửi'"></div>
                <div class="nav-item-text">Tiền gửi</div>
            </div>
            <div class="nav-item">
                <div class="icon pulse-icon" v-tooltip="'Mua hàng'"></div>
                <div class="nav-item-text">Mua hàng</div>
            </div>
            <div class="nav-item">
                <div class="icon sale-icon" v-tooltip="'Bán hàng'"></div>
                <div class="nav-item-text">Bán hàng</div>
            </div>
            <div class="nav-item">
                <div class="icon invoice-icon" v-tooltip="'Quản lí hóa đơn'"></div>
                <div class="nav-item-text">Quản lí hóa đơn</div>
            </div>
            <div class="nav-item">
                <div class="icon stock-icon" v-tooltip="'Kho'"></div>
                <div class="nav-item-text">Kho</div>
            </div>
            <div class="nav-item">
                <div class="icon tools-icon" v-tooltip="'Công cụ dụng cụ'"></div>
                <div class="nav-item-text">Công cụ dụng cụ</div>
            </div>
            <div class="nav-item">
                <div class="icon assets-icon" v-tooltip="''"></div>
                <div class="nav-item-text">Tài sản cố định</div>
            </div>
            <div class="nav-item">
                <div class="icon tax-icon" v-tooltip="'Thuế'"></div>
                <div class="nav-item-text">Thuế</div>
            </div>
            <div class="nav-item">
                <div class="icon price-icon" v-tooltip="'Giá thành'"></div>
                <div class="nav-item-text">Giá thành</div>
            </div>
            <div class="nav-item">
                <div class="icon general-icon" v-tooltip="'Tổng hợp'"></div>
                <div class="nav-item-text">Tổng hợp</div>
            </div>
            <div class="nav-item">
                <div class="icon budget-icon" v-tooltip="'Ngân sách'"></div>
                <div class="nav-item-text">Ngân sách</div>
            </div>
            <div class="nav-item">
                <div class="icon report-icon" v-tooltip="'Báo cáo'"></div>
                <div class="nav-item-text">Báo cáo</div>
            </div>
            <div class="nav-item">
                <div class="icon finance-icon" v-tooltip="'Phân tích tài chính'"></div>
                <div class="nav-item-text">Phân tích tài chính</div>
            </div>
        </div>
    </div>
</template>

<script>

export default {
  name: 'AppSidebar',
}
</script>

<style>
    @import url('../../css/common/sidebar.css');
</style>
