class Admin::ProductsController < Admin::BaseController
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:info] = "Congrats! #{@product.name} created!"
      redirect_to admin_dashboard_path
    else
      flash.now[:alert] = "Sorry, boss lolololololololol.  Something went wrong :(... Please try again."
      render :new
    end
  end

  def index
    if params[:inactive] == "true"
      @products = Product.inactive_index
    else
      @products = Product.active_index
    end
  end

  def update
    @product = Product.find(params[:id])
    status = @product.inactive?

    if @product.update(product_params)
      if status == true && status == @product.inactive?
        flash[:alert] = "Sorry mate! Reactivate the product!"
        return redirect_to admin_products_path(inactive: true)
      elsif status == true
        flash[:info] = "#{@product.name} has been activated"
        return redirect_to admin_products_path(inactive: true)
      elsif @product.inactive?
        flash[:alert] = "#{@product.name} has been deactivated"
      else
        flash[:info] = "Congrats! #{@product.name} has been updated!"
      end
      redirect_to admin_products_path(inactive: false)
    else
      flash.now[:alert] = "Sorry, boss lolololololololol.  Something went wrong :(... Please try again."
      render :new
    end
  end

private

  def product_params
    params.require(:product).permit(:name, :price, :description, :image, :sale, :sale_price, :category_id, :inactive)
  end
end
