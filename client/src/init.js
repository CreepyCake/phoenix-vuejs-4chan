import { socket } from "./channel"
// import store from "./store"

export default function init() {
  socket.connect();

  // if (localStorage.getItem('id_token')) {
  //   store.dispatch('currentUser');
  // }
}
