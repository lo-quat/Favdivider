Rails.application.routes.draw do
  get 'tweets/index'
  resources :users,only: [:edit,:update]
  get 'users/tweet_fetch', to: 'users#tweet_fetch'
  get 'tweets/index', to: 'tweets#index'
  devise_for :users
  get '/auth/:provider/callback', to: 'users#callback'
end
