class Cart
  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_product(product_id, quantity)
    contents[product_id.to_s] ||= 0
    contents[product_id.to_s] += quantity.to_i
  end

  def count
    contents.values.sum
  end
end
