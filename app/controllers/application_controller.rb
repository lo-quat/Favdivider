class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    Tweet.fetch(current_user) if current_user.sign_in_count == 1
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