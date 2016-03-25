class PropertyAmenitizer
  attr_reader :amenities, :property, :params

  def initialize(params, property)
    @property = property
    @params = params
    @amenities = find_amenity_objects
    create_property_amenities
  end

  def find_amenity_objects
    @params.map do |amenity|
      Amenity.find_by(name: amenity)
    end
  end

  def create_property_amenities
    @amenities.each do |amenity|
      @property.amenities << amenity
    end
  end
end
