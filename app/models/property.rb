class Property < ActiveRecord::Base
  has_many :amenities, through: :property_amenities
end
