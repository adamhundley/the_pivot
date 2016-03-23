class User::PropertiesController < ApplicationController
  def new
    @property = Property.new
  end

  def create
    require "pry"; binding.pry
    @property = current_user.properties.create(property_params)
    if @property.save
      flash[:info] = "Congrats #{current_user.fullname}! Your new listing is pending approval."
      redirect_to user_dashboard_path
    else
      flash.now[:alert] = "Something went wrong! Sorry."
      render :new
    end
  end


private

  def property_params
    params.require(:property).permit(:title, :description, :street, :unit, :city, :state, :zip, :price, :bedrooms, :bathrooms, :sleeps, :property_type_id, :image)
  end
end
