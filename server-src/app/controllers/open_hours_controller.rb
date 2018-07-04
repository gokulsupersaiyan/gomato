class OpenHoursController < ApplicationController
  before_action :set_open_hour, only: [:show, :update, :destroy]

  # GET /open_hours
  def index
    @open_hours = OpenHour.all

    render json: @open_hours
  end

  # GET /open_hours/1
  def show
    render json: @open_hour
  end

  # POST /open_hours
  def create
    @open_hour = OpenHour.new(open_hour_params)

    if @open_hour.save
      render json: @open_hour, status: :created, location: @open_hour
    else
      render json: @open_hour.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /open_hours/1
  def update
    if @open_hour.update(open_hour_params)
      render json: @open_hour
    else
      render json: @open_hour.errors, status: :unprocessable_entity
    end
  end

  # DELETE /open_hours/1
  def destroy
    @open_hour.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_open_hour
      @open_hour = OpenHour.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def open_hour_params
      params.require(:open_hour).permit(:from_week_day, :to_week_day, :from_hour_of_day, :to_hour_of_day)
    end
end
