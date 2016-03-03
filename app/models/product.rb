class Product < ActiveRecord::Base
  belongs_to :category
  has_many :order_products

  def display_price
    price.to_i / 100
  end
end
