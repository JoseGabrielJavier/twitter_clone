Rails.application.routes.draw do
  root "static_pages#index"
  get "static_pages/about"
  get "static_pages/contact"

  resources :users
  get "/signup", to: "users#new"

  get "/login", to: "sessions#new"
  delete "/logout", to: "sessions#destroy"
  resources :sessions, only: :create
end
