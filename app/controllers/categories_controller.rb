class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(name: params[:category][:name])
    @category.save
    redirect_to tweets_url
  end
end
