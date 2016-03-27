class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :property
  has_many :reservation_nights
  #validates_uniqueness_of :property_id, scope: [:checkin, :checkout]
end

