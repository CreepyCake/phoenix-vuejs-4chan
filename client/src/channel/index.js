import { Socket } from 'phoenix-elixir'

export const socket = new Socket('ws://localhost:4000/socket');

export function joinUserChannel(id, jwt) {
  let userChannel = socket.channel(`users:${id}`, { token: jwt });

  userChannel.join()
    .receive('ok', _ => {
      console.log('success');
    });
  return userChannel;
}
