class TweetsController < ApplicationController
  def index
    @user = User.find_by(user_name: params[:user_user_name])
  end

  def new
    @user = User.find_by(user_name: params[:user_user_name])
    @tweet = Tweet.new
  end

  def create
    @user = User.find(params[:user_user_name])
    @tweet = Tweet.new(tweet_params)
    @user.tweets << @tweet
  end

  private
  def tweet_params
    params.require(:tweet).permit(:content)
  end
end