class OrderMailer < ApplicationMailer
  default from: "crashatmypad@gmail.com"

  def order_email(reservation)
    @reservation = reservation
    @url = "http://crashatmypad.herokuapp.com"
    mail(to: @reservation.email, subject: "You're about to C.A.M.P!")
  end
end
