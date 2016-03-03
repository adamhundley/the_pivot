class OrdersController < ApplicationController
  helper OrdersHelper

  def new
    @products = OrderProcessor.new(session[:cart]).products
    @order = Order.new
  end

  def create
    order_processor = OrderProcessor.new(session[:cart])
    if current_user
      @order = order_processor.process_current_user(order_params, current_user)
    else
      login_or_create_user
      @order = order_processor.process_current_user(new_user_order_params, current_user)
    end
    if @order.save
      @order.process(order_processor.products)
      flash[:info] = "Thanks for your order! :)"
      session[:cart] = nil
      redirect_to "/users/#{current_user.id}/orders/#{@order.id}/thanks"
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
  def login_or_create_user
    @user = User.find_by(email: params[:email])
    @user = User.new(user_params) if @user.nil?
    if @user.save
      current_user
      session[:user_id] = @user.id
    else
      flash.now[:alert] = "Sorry, friend.  Something went wrong :(... Please try again."
      render :new
    end
  end

  def order_params
    params.require(:order).permit(:first_name, :last_name, :email, :street, :unit, :city, :state, :zip, :user_id)
  end

  def new_user_order_params
    params.permit(:first_name, :last_name, :email, :street, :unit, :city, :state, :zip, :user_id)
  end

  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end
end
