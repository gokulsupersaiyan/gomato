class DishTypesController < ApplicationController
  before_action :set_dish_type, only: [:show, :update, :destroy]

  def index
    @dish_types = DishType.all

    render json: { dishes: @dish_types }
  end

  def show
    render json: { dish: @dish_type }
  end

  def create
    @dish_type = DishType.new(dish_type_params)
    create_model(@dish_type)
  end

  def update
    update_model(@dish_type) { @dish_type.update(dish_type_params) }
  end

  def destroy
    @dish_type.destroy
  end

  private

  def set_dish_type
    @dish_type = DishType.find(params[:id])
  end

  def dish_type_params
    params.require(:dish_type).permit(:dish_type)
  end
end
