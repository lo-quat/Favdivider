class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if current_user.sign_in_count == 1
      Tweet.fetch(current_user)
    else
      flash.delete(:notice)
    end
      tweets_path
  end

  private

  def login_required
    unless current_user
      flash[:notice] = 'ログインしてください'
      redirect_to root_url
    end
  end
end