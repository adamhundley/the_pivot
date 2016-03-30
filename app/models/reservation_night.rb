class ReservationNight < ActiveRecord::Base
  belongs_to :reservation

  def self.book_nights(reservation)
    nights = (reservation.checkin..reservation.checkout).to_a
    nights.each do |night|
      reservation.reservation_nights.create(night: night)
    end
  end
end
