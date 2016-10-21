class User::PropertiesController < ApplicationController
  def create
    @property = current_user.properties.create(property_params)
    PropertyAmenitizer.new(amenity_params, @property)
    ImageCreator.create_images(image_params, @property)
    if @property.save
      flash[:info] = "Congrats #{current_user.fullname}! Your new listing is pending approval."
      redirect_to user_dashboard_path(current_user.slug)
    else
      flash[:alert] = "Sorry! #{@property.errors.full_messages.join(',')}"
      redirect_to new_property_path(current_user.slug)
    end
  end

  def index
    @properties = current_user.properties
    @amenities = Amenity.all
  end

  def update
    @property = current_user.properties.find(params[:id])
    PropertyAmenitizer.update(params[:property][:amenity_ids], @property)
    ImageCreator.create_images(image_params, @property)
    if @property.update(property_params)
      flash[:info] = "You have updated your listing."
      redirect_to user_properties_path(current_user.slug)
    else
      flash[:alert] = "Sorry! #{@property.errors.full_messages.join(',')}"
      redirect_to user_properties_path(current_user.slug)
    end
  end

  def show
    if params[:checkin] && params[:checkout]
      session[:checkin] = params[:checkin]
      session[:checkout] = params[:checkout]
    end

    @property = Property.find(params[:id])
  end

private
  def property_params
    params.require(:property).permit(:title, :description, :street, :unit, :city, :state, :zip, :price, :bedrooms, :bathrooms, :sleeps, :property_type_id, :amenity_ids)
  end

  def image_params
    params[:property][:images]
  end

  def amenity_params
    params[:property][:amenities]
  end
end
