module SessionHelper
  def list_property_redirect
    session[:referrer] = new_property_path
  end

  def redirect_back_or_to(session_referrer = nil)
    session_referrer || user_dashboard_path(current_user.slug)
  end

  def users_status
    params[:status]
  end
end
