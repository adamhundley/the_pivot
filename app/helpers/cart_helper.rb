module CartHelper
  def product_total(product)
    "$#{(product.last * product.first.price) / 100}"
  end

  def cart_total(products)
      products.map do |product|
      product.first.price * product.last
    end.reduce(:+) / 100
  end
end
