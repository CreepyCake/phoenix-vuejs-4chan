<template>
  <div class="signup">
    <router-link to="login">Login</router-link>
    <form class="form row col-md-4" role="form" accept-charset="UTF-8" @submit.prevent="signUp(user)">
      <div class="form-group">
        <label class="sr-only" for="username">Username</label>
        <input type="text"
               class="form-control"
               id="username"
               placeholder="Username"
               v-model="user.username"
               required
        />
      </div>
      <div class="form-group">
        <label class="sr-only" for="password">Password</label>
        <input type="password"
               class="form-control"
               id="password"
               placeholder="Password"
               v-model="user.password"
               required
        />
      </div>
      <div class="form-group">
        <button type="submit" class="btn btn-primary btn-block">
          Sign up
        </button>
      </div>
    </form>
  </div>
</template>

<script>
import auth from '../auth'
export default {
  name: 'SignUp',
  data() {
    return {
      user: {
        username: '',
        password: ''
      }
    }
  },
  methods: {
    signUp(user) {
      auth.signup(this, user, '/')
    }
  }
}
</script>
