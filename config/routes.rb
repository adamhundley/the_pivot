Rails.application.routes.draw do
  root to: 'home#index'

  resources :products, only: [:index, :show]
  resources :cart, only: [:create, :index, :destroy, :update]

  resources :users, only: [:new, :create]

  get "/login", to: "sessions#new"
  delete "/logout", to: "sessions#destroy"

  get "/:name", to: "categories#show"

end
