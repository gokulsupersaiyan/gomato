class Order < ApplicationRecord
  belongs_to :user
  belongs_to :hotel

  validates :delivery_address, :ordered_items, presence: true


  def self.filter_params(params)
    params[:order].require(:order).permit(:hotel_id, :user_id, :delivery_address, :ordered_items)
  end
end
