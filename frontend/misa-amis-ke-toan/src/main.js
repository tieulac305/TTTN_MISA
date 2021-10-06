import Vue from 'vue'
import App from './App.vue'
import router from './router'
import VTooltip from 'v-tooltip'
import VeeValidate from 'vee-validate'

// v-tooltip
Vue.use(VTooltip);
// vee-validate
Vue.use(VeeValidate,{
  events: ['blur', 'close'],
});

Vue.config.productionTip = false;

new Vue({
  router,
  render: h => h(App),
}).$mount('#app');
