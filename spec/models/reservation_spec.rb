require 'rails_helper'

RSpec.describe Reservation, type: :model do
  it { should belong_to :user }
  it { should belong_to :property }
  it { should have_many :reservation_nights }

  #it "has a valid factory" do
    #expect(build(:reservation)).to be_valid
end
