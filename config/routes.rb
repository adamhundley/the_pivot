Rails.application.routes.draw do
  root to: 'home#index'

  resources :products, only: [:index, :show]
  resources :cart, only: [:create, :index]

  get "/:name", to: "categories#show"

end
