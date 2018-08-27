class LikesController < ApplicationController

  def like_handler
    @tweet = Tweet.find(params[:tweet_id])
    @likes = @tweet.likes.map { |like| like.user_id }
    if @likes.include?(current_user.id)
      dislike(current_user, @tweet)
    else
      like(current_user, @tweet)
    end
  end

  private
  def like(user, tweet)
    like = Like.new(user_id: user.id, tweet_id: tweet.id)
    tweet.likes << like
  end

  def dislike(user, tweet)
    like = tweet.likes.find_by(user_id: user.id)
    like.destroy
  end
end