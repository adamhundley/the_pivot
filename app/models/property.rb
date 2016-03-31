class Property < ActiveRecord::Base
  belongs_to :user
  belongs_to :property_type
  has_many :images
  has_many :reservations
  has_many :reservation_nights, through: :reservations
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

  geocoded_by :full_address
  after_validation :geocode

  def self.search(search)
   properties = find_by_city_state_sleeps(parse_search(search))
   search_by_dates(properties)
  end

  def self.find_by_city_state_sleeps(search)
    Property.where(status: "active").order(price: :desc).near("#{@city}, #{@state}, US", @radius).where('sleeps >= ?', @guest).limit(50)
  end

  def self.city_search(params)
    Property.where(status: "active").order(price: :desc).near("#{params[:location]}, US", params[:radius]).where('sleeps >= ?', 3).limit(50)
  end

  def self.default
    Property.where(status: "active").order(price: :desc).near("Denver, CO, US", 3000).where('sleeps >= ?', 3).limit(50)
  end

  def self.by_date
    order(updated_at: :desc)
  end

  def self.search_by_name(search)
    search = search.strip
    user = User.find_by('first_name || last_name || fullname ILIKE ?', "%#{search}%").id
    where(user_id: user)
  end

  def owner
    user = User.find(self.user_id)
    user.fullname
  end

  def display_total
    "$#{self.price}"
  end

  def date
    updated_at.strftime("%B %-d, %Y")
  end

  def self.search_by_dates(properties)
    properties.map do |property|
      property unless property.reservations.reserved?(@checkin, @checkout)
    end.compact
  end

  def self.parse_search(search)
    @city = search[:destination].split(',')[0]
    @state = search[:destination].split(',')[-1].strip
    @guest = search[:guest].split[0]
    @checkin = search[:checkin].delete('-').to_i
    @checkout = search[:checkout].delete('-').to_i
    @radius = search[:radius].to_i
  end

  def nights_reserved
    reservation_nights.map do |res_night|
      res_night.night
    end
  end

  def full_address
    "#{zip}"
  end

  def possible_nights(checkin, checkout)
    (checkin.to_date..checkout.to_date).count
  end

  def cost(checkin, checkout)
    possible_nights(checkin, checkout) * price
  end
end
