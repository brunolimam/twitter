function getMention(tweet) {
  var mention = tweet.match(/@[a-zA-Z1-9]*/)[0];
  var link = mention.slice(1, mention.length);
  return '<a href="/' + link + '">' + mention + '</a>';
}
