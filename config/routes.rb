Rails.application.routes.draw do
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"

  get "/", to: "homepages#index"
  root to: "homepages#index"
  resources :works
  resources :users, only: [:index, :new, :create, :show]
end
