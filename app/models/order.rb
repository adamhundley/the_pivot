class Order < ActiveRecord::Base
  before_save :build_name
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products
  has_many :comments

  validates :user_id, presence: true
  validates :fullname, presence:true
  validates :email, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :zip, presence: true

  def self.search(search)
    where('first_name || last_name || fullname ILIKE ?', "%#{search}%").uniq
  end

  def self.search_by_date(search)
    date = Date.parse(search)
    where(updated_at: date.beginning_of_day..date.end_of_day)
  end

  def build_name
    self.first_name = fullname.split[0]
    self.last_name = fullname.split[-1]
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
    process_stripe_payment
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

  def process_stripe_payment
    customer = Stripe::Customer.create email: email,
                                       card: card_token
    Stripe::Charge.create customer: customer.id,
                          amount: total * 100,
                          description: id,
                          currency: 'usd'
  end

end
