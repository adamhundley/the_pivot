class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    product = Product.find(params[:product_id])
    @cart.add_product(product.id)
    session[:cart] = @cart.contents
    flash[:info] = "#{product.name} added to cart"
    redirect_to products_path
  end

  def index
    ids = session[:cart]
    @products = ids.map do |id, quantity|
      [Product.find(id.to_i), quantity]
    end
  end

  def destroy
    id = params[:id]
    name = find_product(id).name
    @cart.contents.reject! {|k| k == id}
    flash[:alert] = "You have removed #{view_context.link_to name, product_path(id)} from your cart."
    if @cart.contents.empty?
      redirect_to root_path
    else
      redirect_to cart_index_path
    end
  end

private

  def find_product(id)
    Product.find(id)
  end
end
