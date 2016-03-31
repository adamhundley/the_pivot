require 'rails_helper'

RSpec.describe Amenity, type: :model do
  it { should validate_presence_of :name}
  it { should have_many :property_amenities}
  it { should have_many(:properties).through(:property_amenities) }

  it "has a valid factory" do
    expect(build(:amenity)).to be_valid
  end
end
