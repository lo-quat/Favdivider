class HomeController < ApplicationController
  layout 'home'

  def top
    if user_signed_in?
      redirect_to tweets_url
    end
  end
end
