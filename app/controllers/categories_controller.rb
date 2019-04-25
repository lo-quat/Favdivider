class CategoriesController < ApplicationController

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.new(name: params[:category][:name])
    @category.save
    redirect_to new_category_url
  end
end
