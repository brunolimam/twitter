class TweetsController < ApplicationController
  def index
    @user = User.find_by(user_name: params[:user_user_name])
    @tweets = @user.tweets
  end

  def new
    @user = User.find_by(user_name: params[:user_user_name])
    @tweet = Tweet.new
  end

  def create
    @user = User.find_by(user_name: params[:user_user_name])
    @tweet = Tweet.new(tweet_params)
    if @user.tweets << @tweet
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