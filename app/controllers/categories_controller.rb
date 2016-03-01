class CategoriesController < ApplicationController

  def show
    require "pry"
    binding.pry
    @category = Category.find_by(name: params[:name])
  end
end
