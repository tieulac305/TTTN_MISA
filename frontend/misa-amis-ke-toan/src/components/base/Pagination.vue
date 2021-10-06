<template>
    <div class="footer paging">
        <div class="total">Tổng số: <b>{{total}}</b> bản ghi</div>
        <div class="pages d-flex">
            <multiselect
                @input="opt => $emit('size-change', opt.size)"
                v-model="pageSizeSelected"
                :options="pageSizeOptions"
                :allow-empty="false"
                placeholder="Chọn kích thước trang"
                label="name"
                :show-labels="false">
                <span slot="noResult">Không có lựa chọn phù hợp</span>
            </multiselect>
            <div class="pre-page" @click="onClickPreviousPage" :class="{disabled : currentPage == 1}">Trước</div>
            <div class="page-items">
                <button class="page-item" v-show="startPage>1" @click="onClickPage(1)">1</button>
                <span v-show="startPage>2">...</span>
                <button v-for="page in pages" class="page-item"
                    @click="onClickPage(page)"
                    :class="{ active: isPageActive(page) }"
                    :key="page"
                >
                    {{ page }}
                </button>
                <span v-show="endPage<totalPages-1">...</span>
                <button class="page-item" v-show="endPage<totalPages" @click="onClickPage(totalPages)">{{totalPages}}</button>
            </div>
            <div class="next-page" @click="onClickNextPage" :class="{disabled : currentPage == totalPages}">Sau</div>
        </div>
    </div>
</template>

<script>
import Multiselect from 'vue-multiselect'
import Resource from '../../js/common/Resource'

export default {
    name: 'EmployeePagination',
    props: {
        // số trang hiện
        maxVisibleButtons: {
            type: Number,
            required: false,
            default: 3
        },
        // tổng số bản ghi
        total: {
            type: Number,
            required: true,
            default: 0
        },
        // tổng số trang
        totalPages:{
            type: Number,
            default: 0
        },
        // số bản ghi trên mỗi trang
        perPage: {
            type: Number,
            required: true,
            default: 20
        },
        // trang hiện tại
        currentPage: {
            type: Number,
            required: true,
            default: 1
        },
    },
    components:{
        Multiselect
    },
    data(){
        return{
            pageSizeOptions: Resource.SelectOptions.PageSizeOptions,
            pageSizeSelected: {
                size: 20,
                name: '20 bản ghi trên 1 trang',
            },
        }
    },
    computed: {
        // trang bắt đầu hiển thị
        startPage() {
            if (this.currentPage < Math.ceil(this.maxVisibleButtons/2) || this.totalPages - this.maxVisibleButtons < 0) {
                return 1;
            }

            if (this.currentPage > this.totalPages - Math.ceil(this.maxVisibleButtons/2)) { 
                return this.totalPages - this.maxVisibleButtons + 1;
            }

            return this.currentPage - Math.ceil(this.maxVisibleButtons/2) + 1;
        },
        // trang cuối cùng hiển thị
        endPage() {
            return Math.min(this.startPage + this.maxVisibleButtons -1, this.totalPages);
        },
        // các trang được hiển thị
        pages() {
            const range = [];

            for (let i = this.startPage; i <= this.endPage; i+= 1 ) {
                range.push(i);
            }

            return range;
        }
    },
    methods: {
        /**
         * chuyển về trang trước nếu đang ở trang sau 1
         * Author: CpNam 25.07.2021
         */
        onClickPreviousPage() {
            if(this.currentPage > 1)
                this.$emit('page-change', this.currentPage - 1);
        },
        /**
         * chuyển đến trang được bấm
         * Author: CpNam 25.07.2021
         */
        onClickPage(page) {
            this.$emit('page-change', page);
        },
        /**
         * chuyển đến trang tiếp theo nếu đang ở chưa cuối
         * Author: CpNam 25.07.2021
         */
        onClickNextPage() {
            if(this.currentPage < this.totalPages)
                this.$emit('page-change', this.currentPage + 1);
        },
        /**
         * đặt class cho trang hiện tại
         * Author: CpNam 25.07.2021
         */
        isPageActive(page) {
            return this.currentPage === page;
        },
    }
}
</script>

<style>
 @import url('../../css/common/multiselect.css');
 @import url('../../css/common/pagination.css');
</style>