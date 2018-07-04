class OrderedItemsController < ApplicationController
  before_action :set_ordered_item, only: [:show, :update, :destroy]

  # GET /ordered_items
  def index
    @ordered_items = OrderedItem.all

    render json: @ordered_items
  end

  # GET /ordered_items/1
  def show
    render json: @ordered_item
  end

  # POST /ordered_items
  def create
    @ordered_item = OrderedItem.new(ordered_item_params)

    if @ordered_item.save
      render json: @ordered_item, status: :created, location: @ordered_item
    else
      render json: @ordered_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ordered_items/1
  def update
    if @ordered_item.update(ordered_item_params)
      render json: @ordered_item
    else
      render json: @ordered_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ordered_items/1
  def destroy
    @ordered_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ordered_item
      @ordered_item = OrderedItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def ordered_item_params
      params.require(:ordered_item).permit(:quantity)
    end
end
