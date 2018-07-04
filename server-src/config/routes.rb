Rails.application.routes.draw do
  resources :ordered_items
  resources :order_details
  resources :dishes
  resources :open_hours
  resources :hotels
  resources :dish_types
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
