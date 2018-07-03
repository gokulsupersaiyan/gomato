class DishTypesController < ApplicationController
  before_action :set_dish_type, only: [:show, :update, :destroy]

  def initialize
    puts 'init'
  end


  def index
    @dish_types = DishType.all

    render json: @dish_types
  end

  def show
    render json: @dish_type
  end

  def create
    @dish_type = DishType.new(dish_type_params)

    if @dish_type.save
      render json: @dish_type, status: :created, location: @dish_type
    else
      render json: @dish_type.errors, status: :unprocessable_entity
    end
  end

  def update
    if @dish_type.update(dish_type_params)
      render json: @dish_type
    else
      render json: @dish_type.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @dish_type.destroy
  end

  private

  def set_dish_type
    @dish_type = DishType.find(params[:id])
  end

  def dish_type_params
    params.fetch(:dish_type, {})
  end
end
