module PropertiesHelper
  def guest_user?
    if current_user.nil?
      session[:referrer] = new_property_path
      redirect_to login_path
    end
  end

  def set_sessions
    session[:checkin] = params[:checkin]
    session[:checkout] = params[:checkout]
    session[:guests] = params[:guest]
    session[:radius] = params[:radius]
  end

  def property_status
    params[:status]
  end

  def find_location(params)
    if params[:destination]
      params[:destination]
    else
      params[:location]
    end
  end

  def set_geo_info(properties)
    GeoProcessor.new(properties).geo_info
  end

  def set_geo_location(location)
    Geocoder.search(location).first.data["geometry"]["location"]
  end

  def find_city(params)
    params[:location].split(',')[0]
  end

  def set_checkin_placeholder
    if session[:checkin]
      session[:checkin]
    else
      "checkin"
    end
  end

  def set_checkout_placeholder
    if session[:checkout]
      session[:checkout]
    else
      "checkout"
    end
  end

  def set_guests_placeholder
    if session[:guest]
      session[:guest]
    else
      "Guests"
    end
  end

  def min_price(properties)
    if properties.empty?
      100
    else
      properties.min_by do |property|
        property.price
      end.price
    end
  end

  def max_price(properties)
    if properties.empty?
      1000
    else
      properties.max_by do |property|
        property.price
      end.price
    end
  end
end
