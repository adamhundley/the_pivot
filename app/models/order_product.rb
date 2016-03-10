class OrderProduct < ActiveRecord::Base
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true
  validates :product_id, presence: true
  validates :order_id, presence: true

  def total
    quantity * product.price
  end

  def self.top_product_revenue
    top_product.price * (top_product_info[1] / 100)
  end

  def self.top_product
    return if OrderProduct.count == 0
    Product.find(top_product_info[0])
  end

  def self.top_product_info
    group(:product_id).sum(:quantity).sort_by { |product, count| count }.last
  end

  def display_total
    "$#{total / 100}"
  end
end
