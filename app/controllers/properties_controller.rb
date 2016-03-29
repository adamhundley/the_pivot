class PropertiesController < ApplicationController
  include PropertiesHelper

  def new
    @property = Property.new
    @amenities = Amenity.all
    guest_user?
  end

  def index
    session[:checkin] = params[:checkin]
    session[:checkout] = params[:checkout]
    
    if params[:destination]
      @properties = Property.search(params)
      @location = find_location(params)
    else
      @properties = Property.all
    end
  end

  private
    def property_params
      params.require(:property).permit(:title, :description, :street, :unit, :city, :state, :zip, :price, :bedrooms, :bathrooms, :sleeps, :property_type_id)
    end

    def image_params
      params[:property][:image]
    end

    def amenity_params
      params[:property][:amenities]
    end

    def find_location(params)
      params[:destination]
    end
end
