<template>
    <div class="toast-messenger" :class="toastMode">
        <div class="toast-message">
            <div class="toast-icon"></div>
            {{message}}
        </div>
        <div class="toast-close" @click="close()">&times;</div>
    </div>
</template>

<script>
export default {
    name: 'ToastMessenger',
    props: ['message', 'toastMode'],
    methods:{
        close(){
            this.$emit('close');
        }
    },
    mounted(){
        // toast messenger tự đóng sau 5s
        setTimeout(()=>{
            this.close();
        }, 5000);
    }
}
</script>

<style scoped>
 @import url('../../css/common/toastmessenger.css');
</style>