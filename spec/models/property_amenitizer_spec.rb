require 'rails_helper'

RSpec.describe PropertyAmenity, type: :model do
  it "should make propert amenities from the params " do
    property = create(:property)
    create(:amenity)
    params = ["wifi"]
    PropertyAmenitizer.new(params, property)
    expect(property.amenities.count).to eq 1
    expect(property.amenities.first.name).to eq "wifi"
  end
end
