class OrdersController < ApplicationController
  helper OrdersHelper

  def new
    find_session_products
    @order = Order.new
  end

  def create
    @order = User.find(params[:user_id]).orders.new(order_params)
    if @order.save
      find_session_products.each do |product, quantity|
        @order.order_products.create(product_id: product.id, quantity: quantity)
      end
      flash[:info] = "Thanks for your order! :)"
      session[:cart] = nil
      redirect_to "/users/#{params[:user_id]}/orders/#{@order.id}/thanks"
    else
      flash.now[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

  def thanks
    @order = Order.find(params[:order])
  end

  def index
    @orders = User.find(params[:user_id]).orders
  end

private
  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :street, :unit, :city, :state, :zip, :user_id)
  end

  def find_session_products
    @products = session[:cart].map do |id, quantity|
      [Product.find(id.to_i), quantity]
    end
  end
end
