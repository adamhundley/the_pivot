class OrderMailer < ApplicationMailer
  default from: "crashatmypad@gmail.com"

  def order_email(order)
    @order = order
    @url = "http://crashatmypad.herokuapp.com"
    mail(to: @order.email, subject: "You're about to C.A.M.P!")
  end
end
