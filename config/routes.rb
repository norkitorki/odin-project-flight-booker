Rails.application.routes.draw do
  resources :flights, only: :index

  get 'flights/search', to: 'flights#search'

  root "flights#index"
end
