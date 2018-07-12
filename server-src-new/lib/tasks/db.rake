require 'faker'

namespace :db do
  task populate_hotel: :environment do
    1500000.times do
      hotel = Hotel.create(
        name: Faker::Lorem.sentence(3).chars.shuffle.join,
        address: Faker::Lorem.sentence(15).chars.shuffle.join,
        avg_price_for_person: Faker::Number.between(200, 1000),
        min_order: Faker::Number.between(200, 300),
        contact_number: Faker::PhoneNumber.phone_number,
        latitude: (Faker::Number.between(-90, 90).to_s + '.' + Faker::Number.number(10).to_s).to_f,
        longitude: (Faker::Number.between(-180, 180).to_s + '.' + Faker::Number.number(10).to_s).to_f,
        from_week_day: Faker::Number.between(1, 7),
        to_week_day: Faker::Number.between(1, 7),
        from_hour_of_day: Time.now,
        to_hour_of_day: Time.now
      )
      Rails.logger.debug("Creating hotel #{hotel.id}")
    end
  end
end
