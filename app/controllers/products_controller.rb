class ProductsController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
    @product = Product.find(params[:id])
  end

end
