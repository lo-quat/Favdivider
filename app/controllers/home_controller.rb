class HomeController < ApplicationController
  # skip_before_action :login_required, raise: false
  layout 'second_layout'

  def top
    if user_signed_in?
      redirect_to tweets_url
    end
  end
end
