$(document).ready(function() {
  var text = document.getElementById('new_tweet_content');
  var message = document.getElementById('count_message');
  var button = document.getElementById('tweet-button');
  var max_length = 180;

  text.addEventListener("keydown", function(e) {
    var new_length = max_length - text.textLength;
    var new_message = new_length + "/" + max_length;
    message.innerHTML = new_message;
  })
})