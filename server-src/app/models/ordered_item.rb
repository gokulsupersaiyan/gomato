class OrderedItem < ApplicationRecord
  belongs_to :order_detail
  belongs_to :dish, foreign_key: :dish_id

  has_one :dish,foreign_key: :dish_type_id

  validates_numericality_of :quantity, greater_than: 0
end
