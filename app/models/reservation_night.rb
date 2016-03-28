class ReservationNight < ActiveRecord::Base
  belongs_to :reservation

  def self.book_nights(reservation)
    nights = (reservation.checkin..reservation.checkout).to_a
    nights.each do |night|
      reservation.reservation_nights.create(night: night)
    end
  end

  #def self.reserved?(dates)
    #dates.each do |date|
      #include?(ReservationNight.find_by(night: date))
  #end
end
