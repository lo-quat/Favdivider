class UsersController < ApplicationController
  before_action :login_required

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
  end

  def destroy
    current_user.destroy
    flash[:success] = 'アカウントを削除しました'
    redirect_to root_url
  end

  def tweet_fetch
    Tweet.fetch(current_user)
    redirect_to root_url
  end

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
end
