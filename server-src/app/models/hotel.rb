class Hotel < ApplicationRecord
  has_one :open_hour, dependent: :delete
  has_many :dishes
  has_many :dish_types, through: :dishes
end
