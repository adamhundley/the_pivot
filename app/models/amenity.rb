class Amenity < ActiveRecord::Base
  has_many :properties, through: :property_amenities
end
