class Reservation < ActiveRecord::Base
  belongs_to :user
  belongs_to :property
  has_many :reservation_nights
  #validates_uniqueness_of :property_id, scope: [:checkin, :checkout]

  def self.reserved?(checkin, checkout)
    dates = date_range(checkin, checkout)
    all.map do |reservation|
      reservation.check_if_reserved(dates)
    end.flatten.include?(true)
  end

  def self.total_revenue
    sum(:order_total)
  end

  def self.daily_average_revenue
    return if Reservation.count == 0
    total_revenue / group_by_day(:checkin).count.length
  end

  def self.weekly_average_revenue
    return if Reservation.count == 0
    total_revenue / group_by_week(:checkin).count.length
  end


  def check_if_reserved(dates)
    reservation_nights.map do |night|
      dates.include?(night.night)
    end
  end

  def self.date_range(checkin, checkout)
    (checkin.to_s.to_date..checkout.to_s.to_date).to_a
  end
  
  def self.by_date
    order(checkin: :asc)
  end

  def self.reservation_index(status)
    if status == "current"
      where("checkin >= ?", Time.zone.now.beginning_of_day).by_date
    elsif status == "past"
      where("checkin < ?", Time.zone.now.beginning_of_day).by_date
    end
  end

  def process_stripe_payment
    customer = Stripe::Customer.create email: email,
                                       card: card_token
    Stripe::Charge.create customer: customer.id,
                          amount: order_total,
                          description: id,
                          currency: 'usd'
  end

  def formatted_total
    "$#{order_total}"
  end
end
