class PasswordResetsController < ApplicationController
  before_action :set_password_reset, only: [:edit, :update]

  def new
    @password_reset = PasswordReset.new
  end

  def create
    @password_reset = PasswordReset.new(password_reset_params)

    if @password_reset.save || @password_reset.errors[:email].empty?
      redirect_to root_path, success: "A password reset email has been sent if that email exists in our system."
    else
      render :new
    end
  end

  def edit
    @user = @password_reset.user
  end

  def update
    @user = @password_reset.user
    if @user.update(password_params)
      @password_reset.update(expired: true)
      redirect_to root_path, success: "Your password has been changed."
    else
      render :edit
    end
  end

  private

  def set_password_reset
    @password_reset = PasswordReset.find_by!(key: params[:id])
  end

  def password_reset_params
    params.require(:password_reset).permit(:email)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
