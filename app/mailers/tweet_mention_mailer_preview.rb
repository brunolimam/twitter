class TweetMentionMailerPreview < ActionMailer::Preview
  def notify_mentioned_user(user, mention)
    TweetMentionMailer.notify_mentioned_user(User.fisrt, Mention.first)
  end
end