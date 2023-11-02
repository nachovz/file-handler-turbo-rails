class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      redirect_to users_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
