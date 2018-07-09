class DishesController < ApplicationController
  before_action :set_dish, only: [:show, :update, :destroy]

  before_action :check_modify_permission, only: [:create, :update, :destroy]

  def index
    @dishes = Dish.where('hotel_id = ?', params[:hotel_id])
    render 'dishes/index', formats: 'json', handlers: 'jb'
  end

  def show
    render 'dishes/show', formats: 'json', handlers: 'jb', :status => :not_found
  end

  def create
    @dish = Dish.new(dish_params)
    if @dish.save
      render 'dishes/show', formats: 'json', handlers: 'jb'
    else
      render_model_errors(@dish)
    end
  end

  def update
    if @dish.update(dish_params)
      render 'dishes/show', formats: 'json', handlers: 'jb'
    else
      render_model_errors(@dish)
    end
  end

  def destroy
    @dish.destroy
  end

  private

  def set_dish
    @dish = Dish.find_by_id(params[:id])
    render_not_found if @dish.nil?
  end

  def dish_params
    params.require(:dish).permit(:dish_name, :description, :picture_url, :hotel_id, :dish_type_id, :price)
  end

  def check_modify_permission
    render_not_authorized unless has_permission(MODIFY_DISHES)
  end

end
