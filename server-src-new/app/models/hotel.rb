class Hotel < ApplicationRecord
  has_many :dishes
  has_many :orders
  has_many :ratings

  validates :name, :address, :contact_number, :latitude, :longitude, :min_order,
            :from_week_day, :to_week_day, :from_hour_of_day, :to_hour_of_day,
            presence: true

  def self.filter_params(params)
    params[:hotel].permit(:name, :address, :avg_price_for_person, :min_order,
                          :is_closed_for_now, :contact_number, :is_verified,
                          :latitude, :longitude, :from_week_day, :to_week_day, :from_hour_of_day, :to_hour_of_day)
  end


  def self.search(params)
    hotel = Hotel
    if params[:search]
      hotel = hotel.where('name LIKE ?', '%' + params[:search] + '%')
                   .or(Hotel.where(id: Dish.where('dish_name LIKE ?', '%' + params[:search] + '%')))
    else
      hotel = hotel.all
    end
    hotel
  end

end
