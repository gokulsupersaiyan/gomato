class Dish < ApplicationRecord
  belongs_to :hotel

  validates :dish_name, :description, :picture_url, :price, :dish_type, presence: true
  validates_numericality_of :price, greater_than: 0

  def self.filter_params(params)
    params[:dish].permit(:dish_name, :description, :picture_url, :hotel_id, :dish_type, :price)
  end

  def self.search(params)
    params[:dish_page] ||= 1
    dish = Dish
    if params[:search]
      dish = dish.where('dish_name LIKE ?', '%' + params[:search] + '%').paginate(page: params[:dish_page], per_page: 25)
    else
      dish = dish.all
    end
    [dish, { page: params[:dish_page], total_pages: (dish.count.to_f / 25).ceil }]
  end
end

