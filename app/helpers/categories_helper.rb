module CategoriesHelper
  def publish?(category)
    if category.status == 'publish'
      true
    else
      false
    end
  end
end
