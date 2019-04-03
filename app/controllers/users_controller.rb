class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
  end


  private

    def user_params
      params.require(:user).permit(:first_name, :last_name)
    end
end
