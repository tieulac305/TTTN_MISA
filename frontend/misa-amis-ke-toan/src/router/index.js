import Vue from 'vue'
import VueRouter from 'vue-router'
import Employee from '../components/views/employee/Employee.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/employee',
    name: 'Employee',
    component: Employee,
    meta: {
      title: 'Quản lí nhân viên'
    }
  },
  // {
  //   path: '/department',
  //   name: 'Department',
  //   component: Department,
  //   meta: {
  //     title: 'Quản lí phòng ban'
  //   }
  // },
  {
    path: '/',
    name: 'Home',
    meta:{
      title: 'Phần mềm AMIS kế toán'
    }
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.beforeEach((to,from,next)=>{
  document.title = to.meta.title;
  next();
})

export default router
