class Admin::OrdersController < Admin::BaseController

  def index
    if params[:id_search]
      redirect_to admin_order_path(params[:id_search])
    elsif params[:search]
      @orders = Order.search(params[:search]).by_date
    elsif params[:date_search]
      @orders = Order.search_by_date(params[:date_search])
    else
      @orders = Order.by_date
    end
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
    @comment = Comment.new
  end

private
  def order_params
    params.require(:order).permit(:status, :comment)
  end
end
