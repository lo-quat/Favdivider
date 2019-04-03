Rails.application.routes.draw do
  resources :users,only: [:edit,:update]
  devise_for :users
  get '/auth/:provider/callback', to: 'users#callback'
end
