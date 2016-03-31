FactoryGirl.define do
  factory :property_amenity do

  end

  factory :amenity do
    name "wifi"
  end


  factory :property_type do
    name "Entire House/Apartment"
  end

  factory :reservation do
    street "123 Street St."
    city "Denver"
    state "CO"
    zip "80207"
    fullname "Josh Mejia"
    card_token "testtoken"
    email "test@example.com"
    order_total 455
    checkin 20160808
    checkout 20160810
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
    status "active"
  end

  factory :image do
    image_file_name "assets/images/new_york_hero.jpg"
    image_content_type "image/jpeg"
    image_file_size 123
    image_updated_at 20160314
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
