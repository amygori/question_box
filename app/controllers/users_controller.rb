class UsersController < ApplicationController
before_action :authenticate, only: [:edit, :update]
before_action :set_user

  def new
    @user = User.new
  end

  def index
    @user = @current_user
  end

  # def show
  #   @questions = Question.order(created_at: :desc).page params[:page]
  #   @user = User.new
  # end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:current_user_id] = @user.id
      redirect_to root_path, success: "You are successfully registered."
    else
      render :new
    end
  end

  def edit

  end

  def show
    @questions = Question.order(created_at: :desc).page params[:page]
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = current_user
  end
end
