class UsersController < ApplicationController
  def show
    @user = User.find_by(user_name: params[:user_name]) or not_found
  end


  private
  def not_found
    raise ActiveRecord::RecordNotFound
  end

end
