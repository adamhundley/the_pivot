class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_filter :set_time_zone, if: :current_user

  helper_method :current_user

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  private

    def set_time_zone
      if current_user
        Time.zone = current_user.time_zone
      end
    end
end
