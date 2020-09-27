# frozen_string_literal: true

class HomeController < ApplicationController
  layout 'home'
  before_action :signed_in?

  def top; end

  private

  def signed_in?
    redirect_to tweets_url if user_signed_in?
  end
end
