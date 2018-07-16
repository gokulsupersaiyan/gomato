Rails.application.routes.draw do
  devise_for :users

  resources :hotels

  resources :ratings
  get '/ratings/:id/upvote', to: 'ratings#upvote'
  get '/ratings/:id/downvote', to: 'ratings#downvote'


  get '/search', to: 'search#index'

  resources :dishes

  resources :orders

  put '/orders/:id/update_status', to: 'orders#update_status'

  post '/login' => 'authentication#authenticate_user'
  post '/signup' => 'authentication#signup_user'

end
