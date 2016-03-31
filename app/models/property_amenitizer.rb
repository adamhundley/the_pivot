class PropertyAmenitizer
  attr_reader :amenities, :property, :params

  def initialize(params, property)
    @property = property
    @params = params
    @amenities = find_amenity_objects
    create_property_amenities
  end

  def find_amenity_objects
    if params.nil?
      property.amenity_ids = []
    else
      params.map do |amenity|
        Amenity.find_by(name: amenity)
      end
    end
  end

  def create_property_amenities
    amenities.each do |amenity|
      property.amenities << amenity
    end
  end

  def self.update(ids, property)
    if ids.nil?
      property.amenity_ids = []
    else
      new_ids = ids.map do |id|
        id.to_i
      end
      property.amenity_ids = new_ids
    end
  end
end
