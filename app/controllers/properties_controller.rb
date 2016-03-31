class PropertiesController < ApplicationController
  include PropertiesHelper

  def new
    @property = Property.new
    @amenities = Amenity.all
    guest_user?
  end

  def index
    set_sessions
    if params[:destination]
      @properties = Property.search(params)
      location = find_location(params)
      @properties_geo_info = set_geo_info(@properties)
      @geocoded_location = set_geo_location(location)
    elsif params[:location]
      @properties = Property.city_search(params)
      location = find_location(params)
      @properties_geo_info = set_geo_info(@properties)
      @geocoded_location = set_geo_location(location)
    else
      @properties = Property.default
      @properties_geo_info = set_geo_info(@properties)
      @geocoded_location = {"lat"=>39.7392358, "lng"=>-104.990251}
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
end
