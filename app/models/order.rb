class Order < ActiveRecord::Base
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :zip, presence: true

  def total
    order_products.map do |order_product|
      order_product.quantity * order_product.product.price
    end.inject(:+) / 100
  end


  def process(products)
    products.each do |product, quantity|
      order_products.create(product_id: product.id, quantity: quantity)
    end
  end
end
