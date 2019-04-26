Rails.application.routes.draw do
  resources :works
  resources :users, only: [:index, :new]
end
