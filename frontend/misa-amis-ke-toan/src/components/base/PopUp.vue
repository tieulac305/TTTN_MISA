<template>
    <div class="dialog popup"
        @keyup.esc.exact = "close()">
        <div class="cover-background" @click="close()"></div>
        <vue-resizable
            :left="`50%`"
            :top="`calc(100vh/2)`"
            :width="'500px'"
            :height="`fit-content`"
            :dragSelector="'.modal-content, .modal-footer, .modal-body, .modal-header'"
            :fit-parent="false"
            class="modal-content d-flex"
        >
            <div class="modal-body d-flex">
                <div class="modal-body-icon">
                    <div class="icon icon-48 question-icon" v-show="isQuestion"></div>
                    <div class="icon icon-48 warning-icon" v-show="isWarning"></div>
                    <div class="icon icon-48 error-icon"  v-show="isError"></div>
                </div>
                <div v-html="modal.message"></div>
            </div>
            <div class="modal-footer d-flex">
                <div class="d-flex">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"
                        v-show="modal.cancelText" @click="close();">{{modal.cancelText}}</button>
                </div>
                <div class="d-flex">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal"
                        v-show="modal.noText" @click="no(); close();">{{modal.noText}}</button>
                    <button type="button" class="btn btn-primary"
                        @click="ok(); close();" ref="focus">{{modal.continueText}}</button>
                </div>
            </div>
        </vue-resizable>
    </div>
</template>

<script>
// vue-resizable
import VueResizable from "vue-resizable"
// common
import Resource from '../../js/common/Resource'

export default {
    name: 'PopUp',
    props: ['modal'],
    components:{
        VueResizable,
    },
    methods:{
        /**
         * bảo form cha đóng nó
         * Author: CpNam 17.07.2021
         */
        close(){
            this.$emit("close");
        },
        /**
         * thực hiện hành động
         * Author: CpNam 17.07.2021
         */
        ok(){
            if(this.modal.callbackOkFunc){
                this.modal.callbackOkFunc();
            }
            else{
                this.$emit("close");
            }
        },
        no(){
            if(this.modal.callbackNoFunc){
                this.modal.callbackNoFunc();
            }
            else{
                this.$emit("close");
            }
        },
    },
    /**
     * cài đặt mode cho popup
     * Author: CpNam 17.07.2021
     */
    computed: {
        isError(){
            return this.modal.modalMode == Resource.PopUpMode.Error;
        },
        isWarning(){
            return this.modal.modalMode == Resource.PopUpMode.Warning;
        },
        isQuestion(){
            return this.modal.modalMode == Resource.PopUpMode.Question;
        }
    },
    mounted(){
        let me=this;
        me.$nextTick(()=>{
            me.$refs.focus.focus();
        })
    }
}
</script>

<style scoped>
    @import url('../../css/common/dialog.css');
</style>