class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      if user.admin?
        flash[:info] = user.admin_message.sample
        redirect_to admin_dashboard_path
      else
        flash[:info] = "Hey #{user.first_name}, welcome to Little Owl."
        redirect_to root_path
      end
    else
      flash.now[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
