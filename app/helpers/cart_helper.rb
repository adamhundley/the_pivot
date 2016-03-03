module CartHelper
  # def product_total(product)
  #   "$#{(product.last * product.first.price) / 100}"
  # end

  def cart_total(products)
    products.map do |product|
      product.price * product.quantity
    end.reduce(:+) / 100
  end
end
