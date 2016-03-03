Rails.application.routes.draw do
  root to: 'home#index'

  resources :products, only: [:index, :show]
  resources :cart, only: [:create, :index, :destroy, :update]

  resources :users, only: [:new, :create] do
    resources :orders, only: [:new, :index, :create]
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/:name", to: "categories#show"

end
