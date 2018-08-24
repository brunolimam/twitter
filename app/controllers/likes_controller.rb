class LikesController < ApplicationController
  def like
    @tweet = Tweet.find(params[:tweet_id])
    @like = Like.new(user_id: current_user.id, tweet_id: @tweet.id)
    @tweet.likes << @like
  end

  def dislike
    @tweet = Tweet.find(params[:tweet_id])
    @like = Like.find_by(user_id: current_user.id, tweet_id: params[:tweet_id])
    @tweet.likes.delete(@like)
  end
end