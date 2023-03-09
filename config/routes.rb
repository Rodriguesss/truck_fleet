Rails.application.routes.draw do
  resources :deliveries
  resources :travels
  resources :product_types
  resources :cities
  resources :ufs
  resources :truck_drivers
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
