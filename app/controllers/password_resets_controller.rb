class PasswordResetsController < ApplicationController
  def new

  end

  def create
    @password_reset = PasswordReset.new(email: params[:email])

    if @password_reset.save || @password_reset.errors[:email].empty?
      redirect_to root_path, success: "A password reset email has been sent if that email exists in our system."
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

end
