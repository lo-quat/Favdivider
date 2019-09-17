class CategoriesController < ApplicationController
  before_action :set_category,only: [:edit,:update,:destroy]

  def index
    @categories = current_user.categories

    if params[:id].present?
      set_category
    else
      @category = Category.new
    end
  end

  def edit
  end


  def create
    @category = current_user.categories.new(category_params)
    @category.save
    redirect_to categories_url
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to request.referer, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
        format.js { @status = 'success'}
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
        format.js { @status = 'fail'}
      end
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_url
  end

  private

    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
