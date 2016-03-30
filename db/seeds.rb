class Seed
  def initialize
    @images = ["https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1457429804461041.jpg",
               "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1458645252559534.jpg",
               "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1458477215180193.jpg",
               "https://s3.amazonaws.com/crashatmypad/pad+pictures/modern/1458490203467318.jpg"]
    generate_admin
    generate_property_types
    generate_la_properties
    generate_ny_properties
    generate_miami_properties
    generate_amenities
    add_amenities_to_property
  end

  def generate_admin
    fullname = Faker::Name.name
    email = Faker::Internet.free_email(fullname.split[1])
    200.times do |i|
      User.create!(fullname: fullname,
                      email:    "#{i}" + email,
                      password: "password",
                      role:     1,
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

  def generate_la_properties
    user_ids = User.pluck(:id).sample(10)
    10.times do |i|
      user = User.find(user_ids[-1])
      property = Property.create!(title:       Faker::Hipster.sentence(rand(5..7)),
                                  description: Faker::Lorem.paragraph(rand(1..3)),
                                  price:       rand(100..500),
                                  street:      Faker::Address.street_address,
                                  city:        Faker::Address.city,
                                  state:       Faker::Address.state,
                                  zip:         Faker::Address.zip,
                                  bedrooms:    rand(1..16),
                                  bathrooms:    rand(1..6),
                                  sleeps:      rand(1..16),
                                  user_id:     user.id,
                                  status:    [true, false].sample)
      add_property_type_to_property(property)
      generate_reservations_for_property(property)
      generate_images(property)
      user_ids.pop
    end
  end

  def generate_miami_properties
    user_ids = User.pluck(:id).sample(10)
    10.times do |i|
      user = User.find(user_ids[-1])
      property = Property.create!(title:       Faker::Hipster.sentence(rand(5..7)),
                                  description: Faker::Lorem.paragraph(rand(1..3)),
                                  price:       rand(100..500),
                                  street:      Faker::Address.street_address,
                                  city:        Faker::Address.city,
                                  state:       Faker::Address.state,
                                  zip:         Faker::Address.zip,
                                  bedrooms:    rand(1..16),
                                  bathrooms:    rand(1..6),
                                  sleeps:      rand(1..16),
                                  user_id:     user.id,
                                  status:    [true, false].sample)
      add_property_type_to_property(property)
      generate_reservations_for_property(property)
      generate_images(property)
      user_ids.pop
    end
  end

  def generate_ny_properties
    user_ids = User.pluck(:id).sample(10)
    10.times do |i|
      user = User.find(user_ids[-1])
      property = Property.create!(title:       Faker::Hipster.sentence(rand(5..7)),
                                  description: Faker::Lorem.paragraph(rand(1..3)),
                                  price:       rand(100..500),
                                  street:      Faker::Address.street_address,
                                  city:        Faker::Address.city,
                                  state:       Faker::Address.state,
                                  zip:         Faker::Address.zip,
                                  bedrooms:    rand(1..16),
                                  bathrooms:    rand(1..6),
                                  sleeps:      rand(1..16),
                                  user_id:     user.id,
                                  status:    ["pending", "active", "disabled"].sample)
      add_property_type_to_property(property)
      generate_reservations_for_property(property)
      generate_images(property)
      user_ids.pop
    end
  end

  def generate_images(property)
    @images.each do |image|
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

  def generate_reservations_for_property(property)
    user_ids = User.pluck(:id)
    10.times do |i|
      checkin = Faker::Date.between(Date.today, 1.year.from_now)
      checkout = checkin.next.next
      reservation = Reservation.create!(property_id: property.id,
                                        user_id: user_ids[rand(200)],
                                        checkin: checkin,
                                        checkout: checkout)
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
