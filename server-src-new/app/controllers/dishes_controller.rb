class DishesController < ApplicationController

  include UserHelper

  before_action :check_modify_permission, only: [:create, :update, :destroy]

  before_action :set_dish, only: [:show, :update, :destroy]


  def index
    @dishes = Dish.where('hotel_id = ?', params[:hotel_id])
    render 'dishes/index', formats: 'json', handlers: 'jb'
  end

  def show
    if @dish.nil?
      render_not_found
    else
      render 'dishes/show', formats: 'json', handlers: 'jb'
    end
  end

  def create
    @dish = Dish.new(Dish.filter_params(params))
    if @dish.save
      render 'dishes/show', formats: 'json', handlers: 'jb'
    else
      render_model_errors(@dish)
    end
  end

  def update
    if @dish.update(Dish.filter_params(params))
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

  def check_modify_permission
    render_not_authorized unless has_permission(UserHelper::MODIFY_DISHES)
  end

end
