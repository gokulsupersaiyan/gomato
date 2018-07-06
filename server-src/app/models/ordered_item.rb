class OrderedItem < ApplicationRecord
  belongs_to :order_detail
  belongs_to :dish

  validates_numericality_of :quantity, greater_than: 0
end
