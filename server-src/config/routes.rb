Rails.application.routes.draw do
  resources :ratings
  resources :order_details
  resources :dishes
  resources :open_hours
  resources :hotels
  resources :dish_types
  resources :users


  get '/ratings/:id/upvote', to: 'ratings#upvote'
  get '/ratings/:id/downvote', to: 'ratings#downvote'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
