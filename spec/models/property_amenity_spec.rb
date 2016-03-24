require 'rails_helper'

RSpec.describe PropertyAmenity, type: :model do
  it { should belong_to :property}
  it { should belong_to :amenity}

  
end
