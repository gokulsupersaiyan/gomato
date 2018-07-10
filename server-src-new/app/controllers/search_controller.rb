class SearchController < ApplicationController
  def index
    @hotels, @hotel_pagination = Hotel.search(params)
    @dishes, @dish_pagination = Dish.search(params)
    render 'index', formats: 'json', handlers: 'jb'
  end
end