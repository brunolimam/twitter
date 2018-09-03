class TweetsController < ApplicationController
  def timeline
    @followed_users_id = current_user.followed_users.pluck(:id)
    @followed_users_id << current_user.id
    @tweets = Tweet.preload(:user).where(user_id: @followed_users_id).paginate(page: params[:page], :per_page => 5).order('created_at DESC')
    @likes = Like.where(user_id: current_user.id, tweet_id: @tweets.map(&:id)).pluck(:tweet_id)
    @tweet = Tweet.new
    @follow_button = "users/edit_profile"
  end

  def create
    @tweets = []
    @likes = []
    @tweet = Tweet.new(tweet_params)
    current_user.tweets << @tweet
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def like_handler
    @tweet = Tweet.find(params[:tweet_id])
    if @like = current_user.likes.find_by(tweet_id: @tweet.id)
      @like.destroy
    else
      @like = Like.new(user_id: current_user.id, tweet_id: @tweet.id)
      @tweet.likes << @like
    end
    @likes = Like.where(user_id: current_user.id, tweet_id: @tweet.id).map(&:tweet_id)
    @tweet.reload
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
