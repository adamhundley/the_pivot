class PropertiesController < ApplicationController
  include PropertiesHelper
  def new
    @property = Property.new
    @amenities = Amenity.all
    guest_user?
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
