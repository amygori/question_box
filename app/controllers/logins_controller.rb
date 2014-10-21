class LoginsController < ApplicationController
 def index
   @login = Login.new
 end

 def new
   @user = User.new
 end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:current_user_id] = @user.id
      redirect_to root_path, notice: "You have successfully logged in."
    else
      flash.now[:error] = "Your email or password was incorrect."
      render :new
    end
  end

  def destroy
    session[:current_user_id] = nil
    redirect_to root_path, success: "You are successfully logged out."
  end

  private

  def login_params
    params.require(:login).permit(:email, :password)
  end
end

