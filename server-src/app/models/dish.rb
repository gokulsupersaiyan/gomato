class Dish < ApplicationRecord
  belongs_to :hotel
  belongs_to :dish_type ,foreign_key: :dish_type_id

  validates :dish_name, :description, :picture_url, :price, presence: true
  validates_numericality_of :price, greater_than: 0


  def to_builder
    Jbuilder.new do |dish|
      dish.call(self, :id, :dish_name, :description, :picture_url, :price)
      dish.dish_type.call(dish_type, :dish_type)
    end
  end
end