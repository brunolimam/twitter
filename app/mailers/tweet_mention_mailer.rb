class TweetMentionMailer < ApplicationMailer
  def notify_mentioned_user
    @user = params[:user]
    @mention = params[:mention]
    mail(to: @user.email, subject: "Someone mentioned you in a recent tweet")
  end
end
