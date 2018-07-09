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
      render_errors(@hotel)
    end
  end

  def update
    if @rating.update(rating_params)
      render 'show', formats: 'json', handlers: 'jb'
    else
      render_errors(@rating)
    end
  end

  def destroy
    @rating.destroy
  end


  def upvote
    if @rating.increment(:up_votes).save
      render 'show', formats: 'json', handlers: 'jb'
    else
      render_errors(@rating)
    end
  end

  def downvote
    if @rating.increment(:down_votes).save
      render 'show', formats: 'json', handlers: 'jb'
    else
      render_errors(@rating)
    end
  end

  private

  def set_rating
    @rating = Rating.find(params[:id])
  end

  def rating_params
    params.require(:rating).permit(:stars, :review, :reply_from_hotel, :hotel_id, :user_id)
    #TODO : Get user id from session
  end
end