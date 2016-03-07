class Order < ActiveRecord::Base
  before_save :build_full_name
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products
  has_many :comments

  validates :user_id, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :zip, presence: true

  def self.search(search)
    where('first_name || last_name || fullname ILIKE ?', "%#{search}%").uniq
  end

  def build_full_name
    self.fullname = "#{first_name} #{last_name}"
  end

  def full_name
  [first_name, last_name].join(' ')
  end

  def full_name=(name)
    split = name.split(' ', 2)
    self.first_name = split.first
    self.last_name = split.last
  end

  def self.search_by_date(search)
    date = Date.parse(search)
    where(updated_at: date.beginning_of_day..date.end_of_day)
  end

  def total
    order_products.map do |order_product|
      order_product.total
    end.inject(:+) / 100
  end

  def display_total
    "$#{total}"
  end


  def process(products)
    products.each do |product, quantity|
      order_products.create(product_id: product.id, quantity: quantity)
    end
  end

  def product_quantity
    order_products.count
  end

  def name
    "#{first_name} #{last_name}"
  end

  def self.by_date
    order(updated_at: :desc).limit(50)
  end

  def date
    updated_at.strftime("%B %-d, %Y")
  end

end
