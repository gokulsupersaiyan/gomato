class RatingsController < ApplicationController
  before_action :set_rating, only: [:update, :destroy, :upvote, :downvote]

  around_action :authenticate_request!, only: %i[create update destroy upvode downvote]

  def index
    @ratings = Rating.where('hotel_id = ?', params[:hotel_id]).includes(:user)
    render 'index', formats: 'json', handlers: 'jb'
  end


  def create
    @rating = Rating.new(rating_params_for_user)
    if @rating.save
      render 'show', formats: 'json', handlers: 'jb'
    else
      render_model_errors(@hotel)
    end
  end

  def update
    render_not_authorized if @rating.user_id != current_user_id
    if @rating.update(rating_params_for_user)
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
    render_not_authorized unless has_permission(UserHelper::REPLY_TO_REVIEWS)
  end

  private

  def set_rating
    @rating = Rating.find_by_id(params[:id])
    render_not_found if @rating.nil?
  end

  def rating_params_for_user
    params.permit(:stars, :review, :hotel_id).merge(current_user_id)
  end

  def rating_params_for_hotel
    params.permit(:reply_from_hotel, :hotel_id)
  end

end