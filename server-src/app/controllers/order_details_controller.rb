class OrderDetailsController < ApplicationController
  before_action :set_order_detail, only: [:show, :update, :destroy]

  def index
    if params[:hotel_id]
      @order_details = OrderDetail.includes(:user, :ordered_items, :dishes).where('hotel_id = ? ', params[:hotel_id])
      render json: { order_details: @order_details.as_json(include: { user: { except: [:updated_at, :created_at] }, ordered_items: { include: { dish: { except: [:updated_at, :created_at] } }, except: [:updated_at, :created_at] } }, except: [:updated_at]) }
    elsif params[:user_id]
      # @order_details = OrderDetail.includes(:hotel).where('user_id  = ? ', params[:user_id])
      @order_details = OrderDetail.includes(:hotel, :ordered_items, :dishes).where('user_id  = ? ', params[:user_id])
      render json: { order_details: @order_details.as_json(include: { hotel: { except: [:updated_at, :created_at] }, ordered_items: { include: { dish: { except: [:updated_at, :created_at] } }, except: [:updated_at, :created_at] } }, except: [:updated_at]) }
    end
  end

  def show
    render json: @order_detail
  end

  def create
    @order_detail = OrderDetail.new(order_detail_params)
    create_model(@order_detail)
  end

  def update
    update_model(@order_detail) { @order_detail.update(order_detail_params) }
  end

  def destroy
    @order_detail.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order_detail
    @order_detail = OrderDetail.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def order_detail_params
    params.require(:order_detail).permit(:delivery_address)
  end
end
