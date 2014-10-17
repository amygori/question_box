class UserController < ApplicationController
  def new

  end

  def create
    @user = User.new
    if @user.save
      render nothing: true, status: :created
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
