class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :property
  has_many :reservation_nights
  #validates_uniqueness_of :property_id, scope: [:checkin, :checkout]

  def self.available?(checkin, checkout)
    any? do |reservation|
      date_range = (checkin..checkout).to_a
      reservation.reservation_nights.is_available?(date_range)
    end
  end
end

