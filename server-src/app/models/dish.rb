class Dish < ApplicationRecord
  belongs_to :hotel
  belongs_to :dish_type
end
