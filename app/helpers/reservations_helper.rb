module ReservationsHelper
  def reservation_status
    params[:status]
  end

  def display_checkin_date(reservation)
    "Check-in: #{reservation.checkin.strftime("%B %-d, %Y")}"
  end

  def display_checkout_date(reservation)
    "Checkout: #{reservation.checkout.strftime("%B %-d, %Y")}"
  end
end
