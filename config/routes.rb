Rails.application.routes.draw do
  resources :flights, only: :index

  resources :bookings, only: %i[ show new create ]

  root "flights#index"
end
