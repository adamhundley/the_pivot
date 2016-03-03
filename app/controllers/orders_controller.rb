class OrdersController < ApplicationController

  def new
    ids = session[:cart]
    @products = ids.map do |id, quantity|
      [Product.find(id.to_i), quantity]
    end
    @order = Order.new
    # @order_products = @order.OrderProducts.new(@cart)
  end

  def create
    
  end
end
