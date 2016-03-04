Rails.application.routes.draw do
  root to: 'home#index'

  resources :products, only: [:index, :show]
  resource :cart, only: [:show]
  resources :cart_products, only: [:create, :destroy, :update]

  resources :users, only: [:new, :create] do
    resources :orders, only: [:new, :index, :create, :show]
    get "/orders/:order_id/thanks", to: "orders#thanks", as: "thanks"
  end

  namespace :admin do
    get "/dashboard", to: "users#show"
  end
  resources :orders, only: [:new, :create]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/:name", to: "categories#show"
end
