Rails.application.routes.draw do
  resources :flights, only: :index

  resources :bookings, except: %i[ edit update destroy ]

  resources :airlines, only: %i[ index show ]

  root "flights#index"
end
