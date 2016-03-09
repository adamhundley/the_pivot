class Admin::OrdersController < Admin::BaseController

  def index
    @orders = Order.by_date
    if params[:status]
      @orders = Order.where(status: params[:status]).by_date.limit(50)
    elsif params[:id_search]
      if Order.exists?(params[:id_search])
        redirect_to admin_order_path(params[:id_search])
      else
        flash.now[:alert] = "Order #{params[:id_search]}  doesn't exist silly!"
        render :index
      end
    elsif params[:search]
      @orders = Order.search(params[:search]).by_date
    elsif params[:date_search]
      @orders = Order.search_by_date(params[:date_search])
    end
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:info] = "Cheerio! Order #{@order.id} has been updated!"
      redirect_to admin_orders_path(status: @order.status)
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
