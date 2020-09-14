class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    current_user.sign_in_count == 1 ? Tweet.fetch(current_user) : flash.delete(:notice)
    tweets_path
  end

  private

  def login_required
    unless current_user
      redirect_to root_url, notice: 'ログインしてください'
    end
  end
end