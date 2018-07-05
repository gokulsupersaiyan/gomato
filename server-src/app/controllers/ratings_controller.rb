class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :update, :destroy, :upvote, :downvote]

  def index
    @ratings = Rating.where('hotel_id = ?', params[:hotel_id])
    render json: { ratings: @ratings }
  end

  def show
    render json: @rating.to_json_response
  end

  def update
    update_model(@rating) { @rating.update(rating_params) }
  end

  def destroy
    @rating.destroy
  end


  def upvote
    update_model(@rating) { @rating.increment(:upvotes).save }
  end

  def downvote
    update_model(@rating) { @rating.increment(:downvotes).save }
  end

  private

  def set_rating
    @rating = Rating.find(params[:id])
  end

  def rating_params
    params.require(:rating).permit(:starts, :review, :reply_from_hotel, :hotel_id, :user_id)
  end
end
