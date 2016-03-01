class Cart

  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || {}
  end

  def add_product(product_id)
    contents[product_id.to_s] ||= 0
    contents[product_id.to_s] += 1 
  end
end
