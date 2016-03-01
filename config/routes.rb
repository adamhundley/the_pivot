Rails.application.routes.draw do
  root to: 'home#index'

  resources :products, only: [:index, :show]

  get "/:name", to: "categories#show"
end
