class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def new_checkout
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:info] = "Hey #{@user.fullname}, welcome to C.A.M.P."
      redirect_to root_path
    else
      flash.now[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
      render :new
    end
  end

  def show
    @user = current_user
  end

private

  def user_params
    params.require(:user).permit(:fullname, :email, :password)
  end
end
