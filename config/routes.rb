Rails.application.routes.draw do
  resources :flights, only: :index

  resources :bookings, only: %i[ show new create ]

  resources :airlines, only: %i[ index show ]

  root "flights#index"
end
