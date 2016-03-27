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

  it "has a valid factory" do
    expect(build(:property)).to be_valid
  end

  it "fails with missing title" do
    Property.create(title: "", description: "test")
  end


end
