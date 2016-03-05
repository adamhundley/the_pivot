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

private

  def product_params
    params.require(:product).permit(:name, :price, :description, :image, :image_url, :sale?, :sale_price, :category_id)
  end
end
