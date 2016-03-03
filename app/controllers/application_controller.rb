class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :all_categories, :set_cart
  helper_method :current_user


  def all_categories
    @categories = Category.all
  end

  def set_cart
    @cart = Cart.new(session[:cart])
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
