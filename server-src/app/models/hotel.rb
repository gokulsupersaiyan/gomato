class Hotel < ApplicationRecord
  has_one :open_hour, dependent: :delete
  has_many :dishes
  has_many :dish_types, through: :dishes
  has_many :order_details
  has_many :ordered_items, through: :order_details
  has_many :ratings

  validates :name, :address, :contact_number, :latitude, :longitude, :min_order, presence: true

  accepts_nested_attributes_for :open_hour

  def self.filter(_params)
    { hotels: all }
  end

  def self.find_hotel(params)
    hotel = Hotel
    options = {}
    expand = params[:expand] || %i[open_hour dishes ratings]
    expand.each do |entity|
      case entity.to_sym
      when :open_hour
        hotel = hotel.includes(:open_hour)
        options[:open_hour] = {}
      when :ratings
        hotel = hotel.includes(:ratings)
        options[:ratings] = {}
      when :dishes
        hotel = hotel.includes(dishes: { dish_type: {} })
        options[:dishes] = { include: { dish_type: {} } }
      else
        raise "Unknown expand arg #{entity}"
      end
    end
    hotel.find(params[:id]).as_json(include: options)
  end
end
