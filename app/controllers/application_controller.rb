class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if current_user.authenticated?
      Tweet.fetch(current_user)
      tweets_path
    else
      edit_user_path(current_user)
    end
  end

  private

  def login_required
    unless current_user
      flash[:notice] = 'ログインしてください'
      redirect_to root_url
    end
  end
end