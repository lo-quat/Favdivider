class UsersController < ApplicationController

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
  end

  def tweet_fetch
    Tweet.fetch(current_user)
    redirect_to root_url
  end
=begin
  def callback
    auth = request.env['omniauth.auth']
    current_user.access_token = auth[:credentials][:token]
    session[:oauth_token] = auth[:credentials][:token]
    current_user.access_token_secret = auth[:credentials][:secret]
    session[:oauth_token_secret] = auth[:credentials][:secret]
    current_user.twitter_id = auth[:uid]
    current_user.save
    redirect_to edit_user_url(current_user)
  end
=end
  def callback_from(provider)
    provider = provider.to_s

    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', kind: provider.capitalize)
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end


  private

    def user_params
      params.require(:user).permit(:first_name, :last_name)
    end
end
