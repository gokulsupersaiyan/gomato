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
    params[:hotel_page] ||= 1
    hotel = Hotel
    if params[:search]
      hotel = hotel.where('name LIKE ?', '%' + params[:search] + '%').paginate(page: params[:hotel_page], per_page: 25)
    else
      hotel = hotel.paginate(page: params[:hotel_page], per_page: 25).all
    end
    [hotel, { page: params[:hotel_page], total_pages: (hotel.count.to_f / 25).ceil }]
  end

end
