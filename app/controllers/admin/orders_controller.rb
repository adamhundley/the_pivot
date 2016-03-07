class Admin::OrdersController < Admin::BaseController

  def index
    @orders = Order.by_date
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:info] = "Cheerio! Order #{@order.id} has been updated!"
      redirect_to admin_orders_path
    else
      flash.now[:alert] = "Sorry, boss lolololololololol.  Something went wrong ;>(... Please try again."
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  end

private
  def order_params
    params.require(:order).permit(:status, :comment)
  end
end
