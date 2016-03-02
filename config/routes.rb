Rails.application.routes.draw do
  root to: 'home#index'

  resources :products, only: [:index, :show]
  resources :cart, only: [:create, :index, :destroy]

  get "/:name", to: "categories#show"

end
