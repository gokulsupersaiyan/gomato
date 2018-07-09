class OrdersController < ApplicationController

  include UserHelper

  before_action :set_order, only: %i[update destroy show]

  before_action :authorize_order_edit, only: %i[update destroy show]

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
    render_not_authorized unless @order.user_id == current_user_id || has_permission(UserHelper::MODIFY_HOTEL)
  end

  def set_order
    @order = Order.find_by_id(params[:id])
    render_not_found if @order.nil?
  end
end