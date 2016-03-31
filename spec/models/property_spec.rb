require 'rails_helper'

RSpec.describe Property, type: :model do
  describe Property do
    it { should validate_presence_of :title}
    it { should validate_presence_of :description}
    it { should validate_presence_of :price}
    it { should validate_presence_of :street}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip}
    it { should validate_presence_of :bedrooms}
    it { should validate_presence_of :bathrooms}
    it { should validate_presence_of :sleeps}

    it { should belong_to :user }
    it { should have_many :property_amenities }
    it { should have_many :amenities }
    it { should have_many(:reservation_nights).through(:reservations) }
    it { should have_many(:amenities).through(:property_amenities) }
  end

  it "has a valid factory" do
    expect(build(:property)).to be_valid
  end

  it "fails with missing title" do
    Property.create(title: "", description: "test")
  end

  it "search returns only properties with the given parameters" do
    property1 = create(:property, zip: 80220, city: "Denver", state: "CO", sleeps: 4)
    property2 = create(:property, zip: 40391, city: "New York", state: "NY", sleeps: 4)
    search = {:destination =>"Denver, CO", :checkin=>"2016-03-30", :radius => '500', :checkout=>"2016-04-01", :guest=>"4 Guest"}
    properties = Property.search(search)

    expect(properties.count).to eq 1
    expect("Denver").to eq properties.first.city
  end

  it "returns the users fullname" do
    user = create(:user, fullname: "Gregory Peckary")
    property = create(:property, user_id: user.id)

    expect("Gregory Peckary").to eq property.owner
  end

  it "displays the total" do
    property = create(:property, price: 200)

    expect("$200").to eq property.display_total
  end

  it 'returns the formatted updated at date' do
    property = create(:property, updated_at: "Wed, 30 Mar 2016 19:53:41 UTC +00:00")

    expect(property.date).to eq "March 30, 2016"
  end

  it "searches for properties that are avaiable" do
    property1 = create(:property, title: "First property")
    property2 = create(:property, title: "Last property")
    checkin = "20160330".to_date
    checkout = "20160401".to_date
    reservation = property1.reservations.create(checkin: checkin, checkout: checkout)
    search = {:destination =>"Denver, CO", :checkin=>"2016-03-30", :radius => '500', :checkout=>"2016-04-01", :guest=>"4 Guest"}
    Property.parse_search(search)

    ReservationNight.book_nights(reservation)

    properties = [property1, property2]

    result = Property.search_by_dates(properties)

    expect(result.count).to eq 1
    expect(result.first.title).to eq "Last property"
  end

  it "returns the full zipcode" do
    property = create(:property, zip: 80220)

    expect(property.full_address).to eq "80220"
  end

  it 'returns total nights of a reservation' do
    property = create(:property)
    checkin = "20160320".to_date
    checkout = "20160323".to_date
    expect(property.possible_nights(checkin, checkout)).to eq 4
  end

  it 'calculates the total cost of the reservation' do
    property = create(:property, price: 100)
    checkin = "20160320".to_date
    checkout = "20160323".to_date

    expect(property.cost(checkin, checkout)).to eq 400
  end
end
