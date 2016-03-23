FactoryGirl.define do
  factory :amenity do
    name "MyString"
  end
  factory :property_type do
    name "Entire House/Apartment"
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
