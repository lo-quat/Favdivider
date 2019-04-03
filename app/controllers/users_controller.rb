class UsersController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
  end

  def callback
    auth = request.env['omniauth.auth']
    current_user.access_token = auth[:credentials][:token]
    session[:oauth_token] = auth[:credentials][:token]
    current_user.access_token_secret = auth[:credentials][:secret]
    session[:oauth_token_secret] = auth[:credentials][:secret]
    redirect_to edit_user_url(current_user)
  end


  private

    def user_params
      params.require(:user).permit(:first_name, :last_name)
    end
end
