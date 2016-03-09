class User < ActiveRecord::Base
  has_secure_password
  before_save :build_name
  has_many :orders
  has_many :order_products, through: :orders

  validates :fullname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  enum role: %w(default admin super_admin)

  def build_name
    self.first_name = fullname.split[0]
    self.last_name = fullname.split[-1]
  end

  def admin_message
    ["Life is good, #{self.first_name}."]
  end

  def name
    "#{first_name} #{last_name}"
  end
end
