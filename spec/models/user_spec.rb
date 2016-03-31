require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_secure_password }
  it { should validate_presence_of :fullname}
  it { should validate_presence_of :email}
  it { should validate_presence_of :password_digest}


  it { should have_many :properties }
  it { should have_many :reservations }
  it { should have_secure_password }

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  context "has secure password" do
    it { should have_secure_password }
  end

  context "user can be user admin or platform" do
    it { should define_enum_for(:role) }
  end

  it "create first and last name from fullname" do
    user = User.create(fullname: "Nate Venn", email: "nate@example.com", password: "pass")
    user.build_name

    expect(user.first_name).to eq "Nate"
    expect(user.last_name).to eq "Venn"
  end

  it "displays fullname" do
    user = User.create(email: "nate@example.com", fullname: "Nate Venn", password: "password")
    user.build_name

    expect(user.fullname).to eq "Nate Venn"
  end

  it "creates a user seperated hyphen for displaying in the url" do
    user = User.create(email: "nate@example.com", fullname: "Nate Venn", password: "password")
    expect(user.slug).to eq "nate-venn"
  end
end
