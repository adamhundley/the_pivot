require 'rails_helper'

RSpec.describe Category, type: :model do
  context "validations" do
    it {is_expected.to validates_presence_of(:name)}
  end
end
