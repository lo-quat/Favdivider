class Everybodys::UsersController < Everybodys::Base
  before_action :set_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @categories = @user.categories.where(status: :publish)
    render template: 'everybodys/categories/index', user: @user
  end

  private
   def set_user
     @user = User.find(params[:id])
   end
end
