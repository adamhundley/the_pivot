class OrderProcessor
  attr_reader :products

  def initialize(cart_products)
    @products = cart_products
  end

  def process_current_user(params, current_user)
    processed_params = process_user_params(params)
    current_user.orders.new(processed_params)
  end

  def cart_total
      @products.map do |product|
      product.price * product.quantity
    end.reduce(:+) / 100
  end

  def process_user_params(params)
    {
      email: params[:stripeEmail],
      fullname: params[:stripeShippingName],
      street: params[:stripeShippingAddressLine1],
      city: params[:stripeShippingAddressCity],
      state: params[:stripeShippingAddressState],
      zip: params[:stripeShippingAddressZip],
      card_token: params[:stripeToken]
    }
  end
end
