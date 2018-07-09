class HotelsController < ApplicationController
  before_action :set_hotel, only: %i[update destroy show]

  before_action :auth_hotel_edit, only: %i[create update destroy]

  def index
    @hotels = Hotel.all
    render 'index', formats: 'json', handlers: 'jb'
  end

  def show
    render 'show', formats: 'json', handlers: 'jb'
  end

  def create
    @hotel = Hotel.new(hotel_params)
    if @hotel.save
      render 'show', formats: 'json', handlers: 'jb'
    else
      render_model_errors(@hotel)
    end
  end

  def update
    if @hotel.update(hotel_params)
      render 'show', formats: 'json', handlers: 'jb'
    else
      render_model_errors(@hotel)
    end
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
                          :latitude, :longitude, :from_week_day, :to_week_day, :from_hour_of_day, :to_hour_of_day)
  end


  def auth_hotel_edit
    render_not_authorized unless has_permission(MODIFY_HOTEL)
  end
end
