class UserMailer < ApplicationMailer
  default from: "littleowlturing@gmail.com"

  def order_email(order)
    @order = order
    @url = products_url
    mail(to: @order.email, subject: 'test confirmation email')
  end
end
