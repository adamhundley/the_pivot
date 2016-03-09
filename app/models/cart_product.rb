class CartProduct < SimpleDelegator
attr_reader :product, :quantity

  def initialize(product_id, quantity)
    @product = Product.find(product_id)
    @quantity = quantity
    super(@product)
  end

  def subtotal
    product.price * quantity
  end

  def format_subtotal
    subtotal / 100
  end
end
