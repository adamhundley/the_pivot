class Property < ActiveRecord::Base
  belongs_to :user
  belongs_to :property_type
  has_many :images
  has_many :property_amenities
  has_many :amenities, through: :property_amenities
  accepts_nested_attributes_for :amenities

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :bedrooms, presence: true
  validates :bathrooms, presence: true
  validates :sleeps, presence: true

  def self.search(search)
    parse(search)
    Property.where("city = ? and state = ? and sleeps >= ?",
                   @city,
                   @state,
                   @guest)
  end

  def self.search_by_name(search)
    where('first_name || last_name || fullname ILIKE ?', "%#{search}%").uniq
  end

  def self.by_date
    order(updated_at: :desc)
  end

  def owner
    user = User.find(self.user_id)
    user.fullname
  end

  def display_total
    "$#{self.price / 100}"
  end

  def date
    updated_at.strftime("%B %-d, %Y")
  end

  def self.parse(search)
    @city = search[:destination].split(',')[0]
    @state = search[:destination].split(',')[-1].strip
    @guest = search[:guest]
    @checkin = search[:checkin]
    @checkout = search[:checkout]
  end
end
