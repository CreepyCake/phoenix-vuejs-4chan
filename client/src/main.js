// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from "vue"
// import Vuex from "vuex"
import VueRouter from "vue-router"
// import sync from "vue-router-sync"
import init from "./init.js"
// import store from "./store"
import router from "./router"
import App from "./App.vue"

Vue.use(VueRouter)
// Vue.use(Vuex)

// sync(store, router)
Vue.component('app', App)

init()

const app = new Vue({
  el: '#app',
  router,
  components: { App },
  template: '<App/>'
})
