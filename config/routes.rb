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
    resources :products, only: [:new, :create, :index, :update]
    resources :orders, only: [:index, :show, :update]
    resources :comments, only: [:create]
  end

  get "orders/login", to: "orders#checkout_login", as: "checkout_login"
  post "orders/login", to: "orders#checkout_user", as: "checkout_user"

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get "/:name", to: "categories#show"
end
