class Dish < ApplicationRecord
  belongs_to :hotel

  validates :dish_name, :description, :picture_url, :price, :dish_type, presence: true
  validates_numericality_of :price, greater_than: 0

  def self.filter_params(params)
    params[:dish].permit(:dish_name, :description, :picture_url, :hotel_id, :dish_type, :price)
  end
end

