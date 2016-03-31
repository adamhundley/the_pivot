Rails.application.routes.draw do
  root to: 'home#index'

  resources :mailing_list_emails, only: [:create]

  resources :users, only: [:new, :create]

  namespace :admin do
    get "/dashboard", to: "users#show"
    resources :properties, only: [:index, :show, :update]
    resources :reservations, only: [:index, :show]
    resources :users, only: [:index, :update]
  end

  namespace :user, path: ":user_name", as: :user do
    resources :properties, only: [:create, :index, :update, :show]
    resources :reservations, only: [:new, :create, :index]
  end

  resources :properties, only: [:new, :index]

  get ":user_name/dashboard", to: "users#show", as: :user_dashboard

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
