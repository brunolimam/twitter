class TweetsController < ApplicationController
  def timeline
    @followed_users_id = current_user.followed_users.map { |user| user.id }
    @tweets = Tweet.preload(:likes).preload(:user).where(user_id: @followed_users_id).order('created_at DESC')
    @likes = current_user.likes.where(tweet_id: @tweets.map {|tweet| tweet.id} ).pluck(:tweet_id)
    render "tweets/_tweets_list"
  end

  def index
    @user = User.find_by(user_name: params[:user_user_name])
    @tweets = @user.tweets.preload(:likes).order('created_at DESC')
    @likes = current_user.likes.where(tweet_id: @tweets.map {|tweet| tweet.id} ).pluck(:tweet_id)
  end

  def new
    @user = User.find_by(user_name: params[:user_user_name])
    @tweet = Tweet.new
  end

  def show
    @tweet = Tweet.find(params[:id])
    render 'tweets/_tweet_show'
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if current_user.tweets << @tweet
      redirect_to(:back)
    else
      @tweet.errors.details
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
  end

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
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end

  def dislike(user, tweet)
    like = tweet.likes.find_by(user_id: user.id)
    like.destroy
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