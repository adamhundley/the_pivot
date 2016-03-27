require 'rails_helper'

RSpec.describe ReservationNight, type: :model do
  it { should belong_to :reservation }
end

