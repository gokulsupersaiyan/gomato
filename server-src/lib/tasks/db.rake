require 'faker'

namespace :db do
  task populate_dish_type: :environment do
    10.times do
      DishType.create(
        dish_type: Faker::Lorem.sentence(1)
      )
    end
  end

  task populate_hotel: :environment do
    dishes = DishType.all

    500.times do
      hotel = Hotel.create(
        name: Faker::Lorem.sentence(1),
        address: Faker::Lorem.sentence(8),
        avg_price_for_person: Faker::Number.between(200, 1000),
        min_order: Faker::Number.between(200, 300),
        is_closed_for_now: Faker::Boolean.boolean(0.8),
        contact_number: Faker::PhoneNumber.phone_number,
        is_verified: true,
        latitude: (Faker::Number.between(-90, 90).to_s + '.' + Faker::Number.number(10).to_s).to_f,
        longitude: (Faker::Number.between(-180, 180).to_s + '.' + Faker::Number.number(10).to_s).to_f
      )

      Dish.transaction do
        50.times do
          hotel.dishes.create(
            dish_type_id: dishes[Faker::Number.between(200, 1000) % dishes.count].id,
            description: Faker::Lorem.sentence(8),
            dish_name: Faker::Lorem.sentence(1),
            price: Faker::Number.between(80, 250),
            picture_url: 'https://picsum.photos/200/300/?random'
          )
        end
      end
    end
  end
end
