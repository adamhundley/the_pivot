class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :all_categories, :set_cart

  def all_categories
    @categories = Category.all
  end

  def set_cart
    @cart = Cart.new ( session[:cart] )
  end
end
