class CategoriesController < ApplicationController

  def index
    @categories = current_user.categories

    if params[:id].present?
      set_category
    else
      @category = Category.new
    end
  end


  def create
    @category = current_user.categories.new(category_params)
    @category.save
    redirect_to categories_url
  end

  def update
    set_category
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to request.referer, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Category.find(params[:id]).destroy
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
