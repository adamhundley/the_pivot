class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :property
  has_many :reservation_nights
  #validates_uniqueness_of :property_id, scope: [:checkin, :checkout]
  attr_reader :checkin, :checkout, :total_nights

  def initialize(checkin, checkout)
    @checkin = format_date(checkin)
    @checkout = format_date(checkout)
    @total_nights = []
  end

  def add_up_nights
    until nights.include?(checkout)
      total_nights << checkin
      checkin == checkin.next
    end
    require "pry"
    binding.pry
  end

  def format_date(date)
    date.to_s.to_date
  end
end

