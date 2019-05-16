class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    if current_user.authenticated?
      Tweet.fetch(current_user)
      root_path
    else
      edit_user_path(current_user)
    end
  end
end