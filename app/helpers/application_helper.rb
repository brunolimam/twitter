include ActionView::Helpers::UrlHelper

module ApplicationHelper
  def treat_tweet_content(tweet)
    unless tweet.mentions.empty?
      @users_id = tweet.mentions.preload(:users).pluck(:user_id)
      @mentioned_users = User.where(id: @users_id).pluck(:user_name)
      @mention_candidates = tweet.content.scan(/[@][a-zA-Z1-9]*/)
      @mention_candidates.each do |mention|
        if @mentioned_users.include?(mention[1,mention.length])
          tweet.content.sub! mention, (link_to mention, user_path(user_name: mention[1,mention.length]))
        end
      end
    end
    return tweet.content.html_safe
  end
end
