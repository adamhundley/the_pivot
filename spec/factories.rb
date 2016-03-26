FactoryGirl.define do
  factory :property_amenity do

  end

  factory :amenity do
    name "wifi"
  end

  factory :property_type do
    name "Entire House/Apartment"
  end

  factory :property do
    title "Property"
    description "Test description"
    price "1234"
    street "123 Street St."
    city "Denver"
    state "CO"
    zip "80207"
    bedrooms 2
    bathrooms 2
    sleeps 4
    approved false
  end

  factory :user do
    fullname
    email
    password "password"
  end

  sequence :fullname, ["John", "Jim", "Jane", "Sally"].cycle do |n|
    "#{n} Doe"
  end

  sequence :email, ["a", "b", "c", "d"].cycle do |n|
    "#{n}@example.com"
  end

end
