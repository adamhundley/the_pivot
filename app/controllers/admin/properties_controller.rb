class Admin::PropertiesController < ApplicationController

  def index
    @properties = Property.by_date
    if params[:status]
      @properties = Property.where(status: params[:status]).by_date.limit(50)
    elsif params[:id_search]
      if Property.exists?(params[:id_search])
        redirect_to admin_property_path(params[:id_search])
      else
        flash.now[:alert] = "Property #{params[:id_search]} doesn't exist!"
        render :index
      end
    elsif params[:search]
      @properties = Property.search_by_name(params[:search]).by_date
    elsif params[:date_search]
      @properties = Property.search_by_date(params[:date_search])
    end
  end

  def update
    @property = Property.find(params[:id])

    if @property.update(property_params)
      flash[:info] = "Property ID: #{@property.id} from Owner #{@property.owner} has been updated."
      redirect_to admin_properties_path(status: @property.status)
    else
      flash.now[:alert] = "Sorry, boss lolololololololol.  Something went wrong ;>(... Please try again."
      render :new
    end
  end

  def show
    @property = Property.find(params[:id])
  end

  private
  def property_params
    params.require(:property).permit(:status)
  end
end
