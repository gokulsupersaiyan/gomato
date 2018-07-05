class HotelsController < ApplicationController
  before_action :set_hotel, only: %i[update destroy]

  def index
    render json: Hotel.filter(params), status: :ok
  end

  def show
    render json: { hotel: Hotel.find_hotel(params) }, status: :ok
  end

  def create
    @hotel = Hotel.new(hotel_params)
    create_model(@hotel) {
      { hotel: @hotel.as_json(include: { open_hour: {} }) }
    }
  end

  def update
    update_model(@hotel) { @hotel.update(hotel_params) }
  end

  def destroy
    @hotel.destroy
  end

  private

  def set_hotel
    @hotel = Hotel.find(params[:id])
  end

  def hotel_params
    params[:hotel].permit(:name, :address, :avg_price_for_person, :min_order,
                          :is_closed_for_now, :contact_number, :is_verified,
                          :latitude, :longitude,
                          open_hour_attributes: [:from_week_day, :to_week_day, :from_hour_of_day, :to_hour_of_day])
  end

  def open_hours
    params[:hotel][:open_hour].permit(:from_week_day, :to_week_day, :from_hour_of_day, :to_hour_of_day)
  end
end
