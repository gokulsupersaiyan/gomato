class OrderDetail < ApplicationRecord
  has_many :ordered_items
  belongs_to :user
  belongs_to :hotel

  validates :delivery_address, presence: true
end
