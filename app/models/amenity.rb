class Amenity < ActiveRecord::Base
  has_many :property_amenities
  has_many :properties, through: :property_amenities

  validates :name, presence: true
end
