class Dish < ApplicationRecord
  belongs_to :hotel

  validates :dish_name, :description, :picture_url, :price, :dish_type, presence: true
  validates_numericality_of :price, greater_than: 0

end
