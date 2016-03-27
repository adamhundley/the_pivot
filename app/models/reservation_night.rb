class ReservationNight < ActiveRecord::Base
  belongs_to :reservation

  def self.book(nights, reservation)
    nights.each do |night|
      reservation.reservation_nights.create(night: night)
    end
  end

  def self.is_available?(dates)
    any? do |night|
      dates.each do |date|
      night.night != date
      require "pry"
      binding.pry
      end
    end
  end
end
