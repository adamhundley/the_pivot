class Product < ActiveRecord::Base
  belongs_to :category

  def display_price(price)
    price.to_i / 100
  end
end
