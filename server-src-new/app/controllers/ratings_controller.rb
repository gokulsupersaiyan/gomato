class RatingsController < ApplicationController
  before_action :set_rating, only: [:update, :destroy, :upvote, :downvote]

  def index
    @ratings = Rating.where('hotel_id = ?', params[:hotel_id]).includes(:user)
    render 'index', formats: 'json', handlers: 'jb'
  end


  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      render 'show', formats: 'json', handlers: 'jb'
    else
      render_model_errors(@hotel)
    end
  end

  def update
    render_not_authorized if @rating.user_id != current_user_id
    if @rating.update(rating_params)
      render 'show', formats: 'json', handlers: 'jb'
    else
      render_model_errors(@rating)
    end
  end

  def destroy
    render_not_authorized if @rating.user_id != current_user_id
    @rating.destroy
  end


  def upvote
    if @rating.increment(:up_votes).save
      render 'show', formats: 'json', handlers: 'jb'
    else
      render_model_errors(@rating)
    end
  end

  def downvote
    if @rating.increment(:down_votes).save
      render 'show', formats: 'json', handlers: 'jb'
    else
      render_model_errors(@rating)
    end
  end

  def update_hotel_review
    has_permission(UserHelper::MODIFY_HOTEL) unless render_not_authorized
  end

  private

  def set_rating
    @rating = Rating.find(params[:id])
  end

  def rating_params
    params.require(:rating).permit(:stars, :review, :reply_from_hotel, :hotel_id).merge(current_user_id)
  end
end