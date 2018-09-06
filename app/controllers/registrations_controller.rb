class RegistrationsController < Devise::RegistrationsController
  def destroy
    @user = current_user
    if @user.avatar.attached?
      @user.avatar.purge
    end
    super
  end

  private

  def sign_up_params
    params.require(:user).permit(:user_name, :display_name, :profile_description, :avatar, :email, :password, :password_confirmation)
  end
  
  def account_update_params
    params.require(:user).permit(:user_name, :display_name, :profile_description, :avatar, :email, :password, :password_confirmation, :current_password)
  end
end
