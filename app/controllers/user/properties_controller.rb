class User::PropertiesController < ApplicationController
  def new
    @property = Property.new
    @amenities = Amenity.all
  end

  def create
    @property = current_user.properties.create(property_params)
    PropertyAmenitizer.new(amenity_params, @property)
    @image = Image.create(image: image_params)
    if @property.save
      @property.images << @image
      flash[:info] = "Congrats #{current_user.fullname}! Your new listing is pending approval."
      redirect_to user_dashboard_path(current_user.slug)
    else
      flash[:alert] = "Something went wrong! Sorry."
      redirect_to new_user_property_path(current_user.slug)
    end
  end

  def index
    if current_user.properties
      @properties = current_user.properties
      @amenities = Amenity.all
    end
  end

  def update
    @property = Property.find(params[:id])
    if @property.update(property_params)
      PropertyAmenitizer.update(params[:property][:amenity_ids], @property)
      flash[:info] = "You have updated your listing."
      redirect_to user_properties_path(current_user.slug)
    else
      flash.now[:alert] = "Something went wrong :(... Please try again."
      render :new
    end
  end

private

  def property_params
    params.require(:property).permit(:title, :description, :street, :unit, :city, :state, :zip, :price, :bedrooms, :bathrooms, :sleeps, :property_type_id, :amenity_ids)
  end

  def image_params
    params[:property][:image]
  end

  def amenity_params
    params[:property][:amenities]
  end
end
