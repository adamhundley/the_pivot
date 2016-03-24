class PropertyAmenity < ActiveRecord::Base
  belongs_to :property
  belongs_to :amenity
end
