class HotelsController < ApplicationController

  include UserHelper

  before_action :set_hotel, only: %i[update destroy show]

  before_action :authorize_hotel_edit, only: %i[create update destroy]

  around_action :authenticate_request!, only: %i[create update destroy]


  def index
    @hotels, @pagination = Hotel.search(params)
    render 'index', formats: 'json', handlers: 'jb'
  end

  def show
    render 'show', formats: 'json', handlers: 'jb'
  end

  def create
    @hotel = Hotel.new(Hotel.filter_params(params))
    if @hotel.save
      render 'show', formats: 'json', handlers: 'jb'
    else
      render_model_errors(@hotel)
    end
  end

  def update
    if @hotel.update(Hotel.filter_params(params))
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
    @hotel = Hotel.find_by_id(params[:id])
    render_not_found if @hotel.nil?
  end

  def authorize_hotel_edit
    render_permission_denied unless has_permission(UserHelper::MODIFY_HOTEL)
  end
end
