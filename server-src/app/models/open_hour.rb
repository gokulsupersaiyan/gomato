class OpenHour < ApplicationRecord
  belongs_to :hotel

  validates :from_hour_of_day, :to_hour_of_day, :from_week_day, :to_week_day, presence: true
end
