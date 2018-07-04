class OrderDetail < ApplicationRecord
  has_many :ordered_items
  belongs_to :user
  belongs_to :hotel
end
