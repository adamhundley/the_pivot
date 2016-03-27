class ReservationNight < ActiveRecord::Base
  belongs_to :reservation

  def self.book(nights, reservation)
    nights.each do |night|
      reservation.reservation_nights.create(night: night)
    end
  end
end
