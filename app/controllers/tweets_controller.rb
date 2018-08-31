class TweetsController < ApplicationController
  def timeline
    @followed_users_id = current_user.followed_users.map { |user| user.id }
    @tweets = Tweet.preload(:user).where(user_id: @followed_users_id).order('created_at DESC')
    @likes = Like.where(user_id: current_user.id, tweet_id: @tweets.map { |tweet| tweet.id }).as_json(only: [:user_id, :tweet_id])
    @tweets.each do |tweet|
      tweet.liked = @likes.include?({"user_id" => current_user.id, "tweet_id" => tweet.id })
    end
    @tweet =  Tweet.new
    @follow_button = "users/edit_profile"
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
    render @tweet
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
    if @like = current_user.likes.find_by(tweet_id: @tweet.id)
      @like.destroy
      @tweet.liked = false
    else
      @like = Like.new(user_id: current_user.id, tweet_id: @tweet.id)
      @tweet.likes << @like
      @tweet.liked = true
    end
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
