class Hotel < ApplicationRecord
  has_one :open_hour, dependent: :delete
  has_many :dishes
  has_many :dish_types, through: :dishes
  has_many :order_details
  has_many :ordered_items, through: :order_details
  has_many :ratings
end
