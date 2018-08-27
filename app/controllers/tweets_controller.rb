class TweetsController < ApplicationController
  def timeline
    @user = current_user
    @followed_users_id = current_user.followed_users.map { |user| user.id }
    @tweets = Tweet.preload(:likes).includes(:user).where(user_id: @followed_users_id).order('created_at ASC')
    render "tweets/_tweets_list"
  end

  def index
    @user = User.find_by(user_name: params[:user_user_name])
    @tweets = @user.tweets.includes(:likes)
  end

  def new
    @user = User.find_by(user_name: params[:user_user_name])
    @tweet = Tweet.new
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
  
  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end
end