class OrderMailer < ApplicationMailer
  default from: "littleowlturing@gmail.com"

  def order_email(order)
    @order = order
    @url = products_path
    mail(to: @order.email, subject: 'test confirmation email')
  end
end
