class OrdersController < ApplicationController

  include UserHelper

  before_action :set_order, only: %i[update destroy show]

  before_action :authorize_order_edit, only: %i[update destroy show]


  def index
    if params[:hotel_id]
      render_not_authorized unless has_permission(UserHelper::MODIFY_ORDERS)
      @orders = Order.where('hotel_id = ?', params[:hotel_id])
    elsif params[:user_id]
      render_not_authorized unless current_user_id != params[:user_id]
      @orders = Order.where('user_id = ?', params[:user_id])
      render 'show', formats: 'json', handlers: 'jb'
    else
      @orders = Order.where('user_id = ?', params[:user_id])
      render 'show', formats: 'json', handlers: 'jb'
    end
  end


  def create
    @order = Order.new(Order.filter_params(params))
    if @order.save
      render 'show', formats: 'json', handlers: 'jb'
    else
      render_model_errors(@order)
    end
  end

  def update
    if @order.update(Order.filter_params(params))
      render 'show', formats: 'json', handlers: 'jb'
    else
      render_model_errors(@order)
    end
  end

  def destroy
    @order.destroy
  end

  def show
    render 'show', formats: 'json', handlers: 'jb'
  end

  private

  def authorize_order_edit
    render_not_authorized unless @order.user_id == current_user_id || has_permission(UserHelper::MODIFY_ORDERS)
  end

  def set_order
    @order = Order.find_by_id(params[:id])
    render_not_found if @order.nil?
  end
end