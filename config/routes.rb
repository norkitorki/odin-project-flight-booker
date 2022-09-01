Rails.application.routes.draw do
  resources :flights, only: :index

  resources :bookings, only: :new

  root "flights#index"
end
