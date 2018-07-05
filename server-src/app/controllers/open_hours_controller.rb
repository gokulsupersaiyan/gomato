class OpenHoursController < ApplicationController
  before_action :set_open_hour, only: [:show, :update, :destroy]

  def show
    render json: @open_hour.to_json_response
  end

  def create
    @open_hour = OpenHour.new(open_hour_params)
    create_model(@open_hour)
  end

  def update
    update_model(@open_hour) { @open_hour.update(update_params) }
  end

  def destroy
    @open_hour.destroy
  end

  private

  def set_open_hour
    if params[:id]
      @open_hour = OpenHour.find(params[:id])
    elsif params[:hotel_id]
      @open_hour = OpenHour.where('hotel_id = ?', params[:hotel_id])
    end
  end

  def open_hour_params
    params.require(:open_hour).permit(:from_week_day, :to_week_day, :from_hour_of_day, :to_hour_of_day, :hotel_id)
  end

  def update_params
    params.require(:open_hour).permit(:from_week_day, :to_week_day, :from_hour_of_day, :to_hour_of_day)
  end
end
