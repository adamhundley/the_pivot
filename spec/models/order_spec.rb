require 'rails_helper'

RSpec.describe Order, :type => :model do
  def valid_attributes
    {
         user_id:                        1,
        fullname:         "david whitaker",
      first_name:                  "david",
       last_name:               "whitaker",
           email:    "example@example.com",
          street:           "150 E. Blake",
            city:                 "Denver",
             zip:                  "46250",
    }
  end

  it "creates an order" do
    result = Order.new(valid_attributes)
    expect(result).to be_valid
    expect(result.user_id).to eq(1)
    expect(result.first_name).to eq("david")
    expect(result.last_name).to eq("whitaker")
    expect(result.email).to eq("example@example.com")
    expect(result.street).to eq("150 E. Blake")
    expect(result.zip).to eq("46250")
  end

  it "cannot create an order without a user_id" do
    result = Order.new(  first_name:                  "david",
       last_name:               "whitaker",
           email:    "example@example.com",
          street:           "150 E. Blake",
            city:                 "Denver",
             zip:                  "46250")
    expect(result).to be_invalid
  end

  it "cannot create an order without a first_name" do
    result = Order.new(  user_id:                        1,
       last_name:               "whitaker",
           email:    "example@example.com",
          street:           "150 E. Blake",
            city:                 "Denver",
             zip:                  "46250")
    expect(result).to be_invalid
  end

  it "cannot create an order without a last_name" do
    result = Order.new(  user_id:                        1,
       first_name:               "david",
           email:    "example@example.com",
          street:           "150 E. Blake",
            city:                 "Denver",
             zip:                  "46250")
    expect(result).to be_invalid
  end

  it "cannot create an order without an email" do
    result = Order.new(user_id:                        1,
 first_name:                  "david",
  last_name:               "whitaker",
     street:           "150 E. Blake",
       city:                 "Denver",
        zip:                  "46250")
    expect(result).to be_invalid
  end

  it "cannot create an order without a street" do
    result = Order.new(user_id:                        1,
 first_name:                  "david",
  last_name:               "whitaker",
      email:    "example@example.com",
       city:                 "Denver",
        zip:                  "46250")
    expect(result).to be_invalid
  end

  it "cannot create an order without a city" do
    result = Order.new(user_id:                        1,
 first_name:                  "david",
  last_name:               "whitaker",
      email:    "example@example.com",
     street:           "150 E. Blake",
        zip:                  "46250")
    expect(result).to be_invalid
  end

  it "cannot create an order without a zip" do
    result = Order.new(user_id:                        1,
 first_name:                  "david",
  last_name:               "whitaker",
      email:    "example@example.com",
     street:           "150 E. Blake",
     city:                 "Denver")
    expect(result).to be_invalid
  end

  it "it belongs to a user" do
    user = User.create(password: "password", fullname: "david whitaker", first_name: "david", last_name: "whitaker", email: "email@email.com")

    attributes = valid_attributes.merge(user_id: user.id)
    result     = Order.create(attributes)

    expect(result.user).to eq(user)
  end
end
