class User < ActiveRecord::Base
  has_secure_password
  has_many :orders
  has_many :order_products, through: :orders

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  enum role: %w(default admin super_admin) 
end
