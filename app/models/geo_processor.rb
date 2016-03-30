class GeoProcessor
  attr_reader :properties

  def initialize(properties)
    @properties = properties
  end

  def geo_info
    @properties.map do |property|
      [property.latitude, property.longitude, property.id]
    end
  end

end
