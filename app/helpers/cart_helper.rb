module CartHelper
  def cart_total(products)
    products.map do |product|
      product.price * product.quantity
    end.reduce(:+) / 100
  end
end
