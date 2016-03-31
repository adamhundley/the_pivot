class Seed
  def initialize
    @images = ["https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1457429804461041.jpg",
               "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1458645252559534.jpg",
               "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1458477215180193.jpg",
               "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1458490203467318.jpg",
               "https://s3.amazonaws.com/crashatmypad/pad+pictures/outdside/1450360558739668.jpg",
               "https://s3.amazonaws.com/crashatmypad/pad+pictures/outdside/1458645252559534.jpg",
               "https://s3.amazonaws.com/crashatmypad/pad+pictures/outdside/images.jpg",
               "https://s3.amazonaws.com/crashatmypad/pad+pictures/outdside/modular-houses-europe-mima-house-in-alentejo-dezeen-prefabricated-portuguese-home-images.jpg"]

    generate_admin
    generate_users
    generate_property_types
    generate_la_properties
    generate_ny_properties
    generate_miami_properties
    generate_random_properties
    generate_amenities
    add_amenities_to_property
  end

  def generate_admin
      User.create(fullname: Faker::Name.name,
                  email:    "admin@email.com",
                  password: "password",
                  role:     1,
                  )
  end

  def user_status(i)
    case
    when i < 20
      "inactive"
    when i <= 200
      "active"
    end
  end

  def generate_users
    200.times do |i|
      fullname = Faker::Name.name
      first_name = fullname.split[0]
      last_name  = fullname.split[1]
      User.create(
                  first_name: first_name,
                  last_name:  last_name,
                  fullname: fullname,
                  email:    "#{i}" + Faker::Internet.free_email(fullname.split[1]),
                  password: "password",
                  status: user_status(i)
                 )
    end
  end

  def generate_property_types
    types = ["full house/apt", "private room",
             "shared room"]
    3.times do |i|
      PropertyType.create!(name: types[i])
    end
  end

  def status_type(i)
    case
    when i < 10
      "inactive"
    when i < 15
      "pending"
    when i < 50
      "active"
    end
  end

  def generate_la_properties
    20.times do |i|
      user_id = User.pluck(:id).sample
      property = Property.create!(title:       Faker::Hipster.sentence(rand(2..4)),
                                  description: Faker::Lorem.paragraph(rand(5..7)),
                                  price:       rand(100..1000),
                                  street:      Faker::Address.street_address,
                                  city:        "Huntington Park",
                                  state:       "CA",
                                  zip:         "90255",
                                  bedrooms:    rand(1..16),
                                  bathrooms:    rand(1..6),
                                  sleeps:      rand(1..16),
                                  user_id:     user_id,
                                  status:      status_type(i)
                                 )
      add_property_type_to_property(property)
      if property.status == "active" || property.status == "inactive"
        generate_current_reservations_for_property(property)
        generate_past_reservations_for_property(property)
      end
      generate_images(property)
    end
  end

  def generate_miami_properties
    15.times do |i|
      user_id = User.pluck(:id).sample
      property = Property.create!(title:       Faker::Hipster.words(rand(5..7)),
                                  description: Faker::Lorem.paragraph(rand(5..7)),
                                  price:       rand(100..1000),
                                  street:      Faker::Address.street_address,
                                  city:        "Miami",
                                  state:       "FL",
                                  zip:         "33156",
                                  bedrooms:    rand(1..16),
                                  bathrooms:    rand(1..6),
                                  sleeps:      rand(1..16),
                                  user_id:     user_id,
                                  status:      status_type(i)
                                  )
      add_property_type_to_property(property)
      if property.status == "active" || property.status == "inactive"
        generate_current_reservations_for_property(property)
        generate_past_reservations_for_property(property)
      end
      generate_images(property)
    end
  end

  def generate_ny_properties
    20.times do |i|
      user_id = User.pluck(:id).sample
      property = Property.create!(title:       Faker::Hipster.sentence(rand(3..5)),
                                  description: Faker::Lorem.paragraph(rand(5..7)),
                                  price:       rand(100..1000),
                                  street:      Faker::Address.street_address,
                                  city:        "Brooklyn",
                                  state:       "NY",
                                  zip:         "11206",
                                  bedrooms:    rand(1..16),
                                  bathrooms:    rand(1..6),
                                  sleeps:      rand(1..16),
                                  user_id:     user_id,
                                  status:    status_type(i)
                                  )
      add_property_type_to_property(property)
      if property.status == "active" || property.status == "inactive"
        generate_current_reservations_for_property(property)
        generate_past_reservations_for_property(property)
      end
      generate_images(property)
    end
  end

  def generate_random_properties
    150.times do |i|
      user_id = User.pluck(:id).sample
      property = Property.create!(title:       Faker::Hipster.sentence(rand(3..5)),
                                  description: Faker::Lorem.paragraph(rand(5..7)),
                                  price:       rand(100..1000),
                                  street:      Faker::Address.street_address,
                                  city:        Faker::Address.city,
                                  state:       Faker::Address.state,
                                  zip:         Faker::Address.zip,
                                  bedrooms:    rand(1..16),
                                  bathrooms:    rand(1..6),
                                  sleeps:      rand(1..16),
                                  user_id:     user_id,
                                  status:    status_type(i)
                                  )
      add_property_type_to_property(property)
      if property.status == "active" || property.status == "inactive"
        generate_current_reservations_for_property(property)
        generate_past_reservations_for_property(property)
      end
      generate_images(property)
    end
  end

  def generate_images(property)
    @images.shuffle.take(4).each do |image|
      property.images.create!(image: image)
    end
  end

  def generate_amenities
    amenities = ["tv", "washer/dryer", "internet",
                 "cable", "kitchen", "pool", "Pets allowed",
                 "fireplace", "Free Parking", "Esentials"]
    10.times do |i|
      Amenity.create!(name: amenities[i])
    end
  end

  def add_amenities_to_property
    Property.all.each do |property|
      amenities = Amenity.all.take(rand(3..10))
      amenities.each do |amenity|
        property.amenities << amenity
      end
    end
  end

  def generate_current_reservations_for_property(property)
    5.times do |i|
      customer = User.all.sample
      checkin = Faker::Date.between(Date.today, 1.year.from_now)
      checkout = checkin.next.next
      reservation = Reservation.create!(property_id: property.id,
                                        user_id:     customer.id,
                                        fullname:    customer.fullname,
                                        order_total: rand(100..1000),
                                        state: property.state,
                                        city:  property.city,
                                        checkin:     checkin,
                                        checkout:    checkout
                                        )
      ReservationNight.book_nights(reservation)
    end
  end

  def generate_past_reservations_for_property(property)
    2.times do |i|
      customer = User.all.sample
      checkin = Faker::Date.between(Date.today, 1.year.ago)
      checkout = checkin.next.next
      reservation = Reservation.create!(user_id:     customer.id,
                                        fullname:    customer.fullname,
                                        order_total: rand(100..1000),
                                        property_id: property.id,
                                        state: property.state,
                                        city:  property.city,
                                        checkin:     checkin,
                                        checkout:    checkout
                                        )
      ReservationNight.book_nights(reservation)
    end
  end

  private
    def add_property_type_to_property(property)
      property_type = PropertyType.find(rand(1..3))
      property_type.properties << property
    end
end
Seed.new
