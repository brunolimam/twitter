$(document).ready(function() {
  var text = document.getElementById('new_tweet_content');
  var message = document.getElementById('count_message');
  var button = document.getElementById('new_tweet_button');
  var max_length = 180;
  text.addEventListener("keyup", function(e) {
    var new_length = max_length - text.textLength;
    if (new_length < 0) {
      button.setAttribute('disabled', true);
      message.style.color = 'red';
    } else {
      button.removeAttribute('disabled');
      message.style.color = 'black';
    }
    var new_message = new_length + "/" + max_length;
    message.innerHTML = new_message;
  })
})