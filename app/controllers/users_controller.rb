class UsersController < ApplicationController
  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
  end


  private

    def user_params
      params.require(:user).permit(:first_name, :last_name)
    end
end
