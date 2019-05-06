Rails.application.routes.draw do
  get "/", to: "homepages#index"
  root to: "homepages#index"
  resources :works
  resources :users, only: [:index, :new]
end
