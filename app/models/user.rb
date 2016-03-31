class User < ActiveRecord::Base
  has_secure_password
  before_save :build_name
  before_create :create_slug
  has_many :reservations
  has_many :properties

  validates :fullname, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true

  enum role: %w(default platform_admin)

  def build_name
    self.first_name = fullname.split[0]
    self.last_name = fullname.split[1..-1].join(" ")
  end

  def create_slug
    self.slug = fullname.parameterize
  end
end
