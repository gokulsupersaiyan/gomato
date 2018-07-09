class Order < ApplicationRecord
  belongs_to :user
  belongs_to :hotel

  validates :delivery_address, :ordered_items, presence: true

end
