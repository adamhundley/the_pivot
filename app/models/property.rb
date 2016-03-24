class Property < ActiveRecord::Base
  belongs_to :property_type
  has_many :property_amenities
  has_many :amenities, through: :property_amenities
  accepts_nested_attributes_for :amenities
end
