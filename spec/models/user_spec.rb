require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }
  it { should validate_presence_of :fullname}
  it { should validate_presence_of :email}
  it { should validate_presence_of :password_digest}


  it { should have_many :properties }

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end
end
