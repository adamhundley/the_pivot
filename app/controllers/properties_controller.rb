class PropertiesController < ApplicationController
  def index
    @properties = Property.search(params)
    @location = find_location(params)
  end

  private
    def find_location(params)
      params[:destination]
    end
end
