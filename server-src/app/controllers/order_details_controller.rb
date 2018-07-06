class OrderDetailsController < ApplicationController
  before_action :set_order_detail, only: [:show, :update, :destroy]

  def index
    if params[:hotel_id]
      puts OrderDetail.includes(:user, :ordered_items, :dishes).where('hotel_id = ? ', params[:hotel_id]).to_sql
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
    create_model(@order_detail) {
      {
          orderdetail: @order_detail.as_json(include: { ordered_items: {} })
      }
    }
  end

  def update
    update_model(@order_detail) { @order_detail.update(order_detail_params) }
  end

  def destroy
    @order_detail.destroy
  end

  private

  def set_order_detail
    @order_detail = OrderDetail.find(params[:id])
  end

  def order_detail_params
    ordered_items = params[:orderdetail][:ordered_items]
    params[:orderdetail].delete(:ordered_items)
    params[:orderdetail][:ordered_items_attributes] = ordered_items
    params[:orderdetail].permit(:delivery_address, :user_id, :hotel_id,
                                ordered_items_attributes: [[:quantity, :dish_id]])

  end
end
