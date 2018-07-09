Rails.application.routes.draw do
  devise_for :users

  resources :hotels

  resources :ratings
  get '/ratings/:id/upvote', to: 'ratings#upvote'
  get '/ratings/:id/downvote', to: 'ratings#downvote'


  resources :dishes

  resources :orders

end
