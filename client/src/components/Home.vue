<template>
  <div>
    <h1>Home page</h1>
    <h2>Hello, {{user.username}}</h2>
    <a href="/login" @click.prevent="logout()">Logout</a>
  </div>
</template>

<script>
import SignUp from './SignUp.vue'
import Login from './Login.vue'
import auth from '../auth'
export default {
  name: 'Home',
  data() {
    return {
      user: {}
    }
  },
  beforeCreate() {
    auth.currentUser(this)
  },
  methods: {
    logout() {
      auth.logout(this)
    }
  }
}
</script>
