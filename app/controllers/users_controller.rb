class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:info] = "Hey #{@user.first_name}, welcome to Little Owl."
      redirect_to root_path
    else
      flash.now[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
      render :new
    end
  end

private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
