import router from '../router'
import { joinUserChannel } from '../channel'
import {httpPost, httpGet, httpDelete} from '../utils'

const API_URL = `http://localhost:4000/api`
const SIGN_UP_URL = `${API_URL}/sign_up/`
const SIGN_IN_URL = `${API_URL}/sign_in/`
const SIGN_OUT_URL = `${API_URL}/sign_out/`
const CURRENT_USER_URL = `${API_URL}/user/`

let userChannel = null

export default {
  user: {
    authenticated: !!window.localStorage.getItem('id_token')
  },

  login (context, session, redirect) {
    httpPost(SIGN_IN_URL, { session })
      .then(resp => {
        window.localStorage.setItem('id_token', resp.jwt)

        this.user.authenticated = true
        userChannel = joinUserChannel(resp.user.id, resp.jwt)

        if (redirect) {
          context.$router.push({path: redirect})
        }
      }, resp => {
        context.error = resp.message
      })
  },

  currentUser (context) {
    httpGet(CURRENT_USER_URL)
      .then(resp => {
        context.user = resp.user
      }, _ => {
        window.localStorage.removeItem('id_token')
        this.user.authenticated = false
        context.$router.push({
          path: '/login',
          query: {redirect: context.$route.fullPath}
        })
      })
  },

  signup (context, user, redirect) {
    httpPost(SIGN_UP_URL, { user })
      .then(resp => {
        window.localStorage.setItem('id_token', resp.jwt)
        this.user.authenticated = true
        userChannel = joinUserChannel(resp.user.id, resp.jwt)

        if (redirect) {
          context.$router.push({path: redirect})
        }
      }, resp => {
        console.log(resp.errors)
        context.errors = resp.errors
      })
  },

  logout (context) {
    httpDelete(SIGN_OUT_URL)
      .then(data => {
        window.localStorage.removeItem('id_token')
        this.user.authenticated = false
        context.$router.push({path: '/login'})
      }, error => {
        console.log(error.message)
      })
  },

  checkAuth () {
    const jwt = window.localStorage.getItem('id_token')
    this.user.authenticated = !!jwt
  }
}
