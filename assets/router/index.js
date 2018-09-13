import VueRouter from 'vue-router'
import SignUp from '../components/SignUp.vue'
import Login from '../components/Login.vue'
import Home from '../components/Home.vue'

const router = new VueRouter({
  mode: 'history',
  routes: [
    {
      name: 'home',
      path: '/',
      component: Home
    }]
  })

export default router
