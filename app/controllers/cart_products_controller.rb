class CartProductsController < ApplicationController

  def create
    product = Product.find(params[:product_id])
    @cart.add_product(product.id, params[:quantity])
    session[:cart] = @cart.contents
    flash[:info] = "#{product.name} added to cart"
    redirect_to products_path
  end

  def destroy
    product = find_product(params[:id])
    @cart.remove_product_from_cart(product.id.to_s)
    flash[:alert] = "You have removed #{view_context.link_to product.name, product_path(product.id)} from your cart."
    if @cart.empty?
      redirect_to root_path
    else
      redirect_to cart_path
    end
  end

  def update
    @cart.update(params)
    redirect_to cart_path
  end

  private

  def find_product(id)
    Product.find(id)
  end

end
