<template>
  <div class="login">
    <router-link to="signup">Create account</router-link>
    <form class="form row col-md-4" role="form" accept-charset="UTF-8" @submit.prevent="login(session)">
      <div class="form-group">
        <label class="sr-only" for="username">Username</label>
        <input type="text"
               class="form-control"
               id="username"
               placeholder="Username"
               v-model="session.username"
               required
        />
      </div>
      <div class="form-group">
        <label class="sr-only" for="password">Password</label>
        <input type="password"
               class="form-control"
               id="password"
               placeholder="Password"
               v-model="session.password"
               required
        />
      </div>
      <div class="form-group">
        <button type="submit" class="btn btn-primary btn-block">
          Login
        </button>
      </div>
    </form>
  </div>
</template>

<script>
import auth from '../auth'
export default {
  name: 'Login',
  data() {
    return {
      session: {
        username: '',
        password: ''
      }
    }
  },
  methods: {
    login(session) {
      auth.login(this, session, '/')
    },
  }
}
</script>
