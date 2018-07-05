class DishesController < ApplicationController
  before_action :set_dish, only: [:show, :update, :destroy]

  def index
    @dishes = Dish.where('hotel_id = ?', params[:hotel_id])
    render json: { dishes: @dishes.as_json(include: :dish_type) }
  end

  def show
    render json: @dish
  end

  def create
    @dish = Dish.new(dish_params)
    create_model(@dish)
  end

  def update
    update_model(@dish) { @dish.update(dish_params) }
  end

  def destroy
    @dish.destroy
  end

  private

  def set_dish
    @dish = Dish.find(params[:id])
  end

  def dish_params
    params.require(:dish).permit(:dish_name, :description, :picture_url, :hotel_id, :dish_type_id, :price)
  end
end
