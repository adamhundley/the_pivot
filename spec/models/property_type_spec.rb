require 'rails_helper'

RSpec.describe PropertyType, type: :model do
  it { should have_many :properties }
  it { should validate_presence_of :name }
end
