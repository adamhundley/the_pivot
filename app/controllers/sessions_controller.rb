class SessionsController < ApplicationController
  include SessionHelper
  def new
    session[:return_to] ||= request.referer
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id]  = user.id

      if user.platform_admin?
        redirect_to admin_dashboard_path
      else
        flash[:info] = "Hey #{user.fullname}, welcome to C.A.M.P"
        if session[:return_to]
          redirect_to session.delete(:return_to)
        else
          redirect_to redirect_back_or_to(session[:referrer])
        end
      end
    else
        flash.now[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
        render :new
    end
  end

  def destroy
    flash[:bye] = "Sad to see you go #{current_user.fullname}. Come back again soon. 👋"
    session.clear
    redirect_to root_path
  end
end
