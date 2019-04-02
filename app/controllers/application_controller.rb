class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    edit_user_registration_path
  end

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
  end
end
