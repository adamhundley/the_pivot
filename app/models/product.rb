class Product < ActiveRecord::Base
  belongs_to :category
  has_many :order_products

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true
  validates :description, presence: true
  validates :image_url, presence: true
  validates :category_id, presence: true


  def display_price
    price.to_i / 100
  end
end
