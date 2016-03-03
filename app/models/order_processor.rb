class OrderProcessor
  attr_reader :products

  def initialize(cart)
    @products = find_cart_products(cart)
  end

  def process_current_user(params, current_user)
    current_user.orders.new(params)
  end

  def find_cart_products(cart)
    cart.map do |id, quantity|
      [Product.find(id.to_i), quantity]
    end
  end

  def product_total(product)
    "$#{(product.last * product.first.price) / 100}"
  end

  def cart_total
      @products.map do |product|
      product.first.price * product.last
    end.reduce(:+) / 100
  end
end
