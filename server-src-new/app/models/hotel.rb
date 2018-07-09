class Hotel < ApplicationRecord
  has_many :dishes
  has_many :orders
  has_many :ratings

  validates :name, :address, :contact_number, :latitude, :longitude, :min_order,
            :from_week_day, :to_week_day, :from_hour_of_day, :to_hour_of_day,
            presence: true

end
