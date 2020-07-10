import HangmanSocket from "./hangman_socket.js"

window.onload = function() {

  let socket = new HangmanSocket()
  socket.join_to_hangman()
}