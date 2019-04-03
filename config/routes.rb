Rails.application.routes.draw do
  resources :users,only: [:edit,:update]
  devise_for :users
end
