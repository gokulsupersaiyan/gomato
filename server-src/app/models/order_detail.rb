class OrderDetail < ApplicationRecord
  has_many :ordered_items
  has_many :dishes, through: :ordered_items
  belongs_to :user
  belongs_to :hotel

  validates :delivery_address, presence: true

  accepts_nested_attributes_for :ordered_items

end
