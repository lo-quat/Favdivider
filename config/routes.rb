Rails.application.routes.draw do
  resources :users,only: [:edit,:update]
  get 'users/tweet_fetch', to: 'users#tweet_fetch'
  devise_for :users
  get '/auth/:provider/callback', to: 'users#callback'
end
