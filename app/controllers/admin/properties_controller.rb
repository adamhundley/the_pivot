class Admin::PropertiesController < ApplicationController

  def index
    @properties = Property.by_date
    @properties = Property.where(status: params[:status]).by_date.limit(50)
  end

  def update
    @property = Property.find(params[:id])

    @property.update(property_params)
    flash[:info] = "Property ID: #{@property.id} from Owner #{@property.owner} has been updated."
    redirect_to admin_properties_path(status: @property.status)
  end

  def show
    @property = Property.find(params[:id])
  end

  private
  def property_params
    params.require(:property).permit(:status)
  end
end
