class Property < ActiveRecord::Base
  belongs_to :user
  belongs_to :property_type
  has_many :images
  has_many :reservations
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

  def self.parse(search)
    @city = search[:destination].split(',')[0]
    @state = search[:destination].split(',')[-1].strip
    @guest = search[:guest]
    @checkin = search[:checkin]
    @checkout = search[:checkout]
  end
end
