require 'rails_helper'

RSpec.describe Property, type: :model do
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

  it "has a valid factory" do
    expect(build(:property)).to be_valid
  end

  it "fails with missing title" do
    Property.create(title: "", description: "test")
  end

  it "search returns only properties with the given parameters" do
    property1 = create(:property, zip: 80220, city: "Denver", state: "CO", sleeps: 4)
    property2 = create(:property, zip: 40391, city: "New York", state: "NY", sleeps: 4)
    search = {:destination =>"Denver, CO", :checkin=>"2016-03-30", :checkout=>"2016-04-01", :guest=>"4 Guest"}
    properties = Property.search(search)

    expect(1).to eq properties.count
    expect("Denver").to eq properties.first.city
  end

  it "returns the users fullname" do
    user = create(:user, fullname: "Gregory Peckary")
    property = create(:property, user_id: user.id)

    expect("Gregory Peckary").to eq property.owner
  end


end
