module CartHelper
  def cart_total(products)
    raw_cart_total(products) / 100
  end

  def raw_cart_total(products)
    products.map do |product|
      product.price * product.quantity
    end.reduce(:+)
  end
end
