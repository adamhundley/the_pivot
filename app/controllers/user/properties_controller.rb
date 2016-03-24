class User::PropertiesController < ApplicationController
  def new
    @property = Property.new
    @amenities = Amenity.all
  end

  def create
    @property = current_user.properties.create(property_params)
    @image = Image.create(image: image_params)
    if @property.save
      @property.images << @image
      flash[:info] = "Congrats #{current_user.fullname}! Your new listing is pending approval."
      redirect_to user_dashboard_path
    else
      flash.now[:alert] = "Something went wrong! Sorry."
      render :new
    end
  end


private

  def property_params
    params.require(:property).permit(:title, :description, :street, :unit, :city, :state, :zip, :price, :bedrooms, :bathrooms, :sleeps, :property_type_id)
  end

  def image_params
    params[:property][:image]
  end
end
