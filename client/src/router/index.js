import VueRouter from 'vue-router'
import SignUp from '../components/SignUp.vue'
import Login from '../components/Login.vue'
import Home from '../components/Home.vue'
import auth from '../auth'

const requireAuth = (to, _from, next) => {
  if (!auth.user.authenticated) {
    next({
      path: '/login',
      query: { redirect: to.fullPath }
    })
  } else {
    next()
  }
}

const afterAuth = (_to, from, next) => {
  if (auth.user.authenticated) {
    next(from.path)
  } else {
    next()
  }
}

const router = new VueRouter({
  mode: 'history',
  routes: [
    { path: '/', component: Home, beforeEnter: requireAuth },
    { path: '/login', component: Login, beforeEnter: afterAuth },
    { path: '/signup', component: SignUp, beforeEnter: afterAuth },]
  })

export default router
