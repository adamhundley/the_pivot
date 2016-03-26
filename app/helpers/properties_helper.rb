module PropertiesHelper
  def guest_user?
    if current_user.nil?
      session[:referrer] = new_property_path
      redirect_to login_path
    end
  end
end
