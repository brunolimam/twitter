# Preview all emails at http://localhost:3000/rails/mailers/tweet_mention_mailer
class TweetMentionMailerPreview < ActionMailer::Preview
  def notify_mentioned_user
    TweetMentionMailer.notify_mentioned_user(User.first, Mention.first)
  end
end
