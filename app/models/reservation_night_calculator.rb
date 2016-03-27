class ReservationNightCalculator
  attr_reader :checkin, :checkout, :total_nights

  def initialize(checkin, checkout)
    @checkin = format_date(checkin)
    @checkout = format_date(checkout)
  end

  def add_up_nights
    total_nights = [checkin]
    until total_nights.include?(checkout)
      total_nights << total_nights[-1].next
    end
    total_nights
  end

  def format_date(date)
    date.to_s.to_date
  end
end
