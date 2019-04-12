Rails.application.routes.draw do
  resources :users,only: [:edit,:update]
  get 'users/tweet_fetch', to: 'users#tweet_fetch'
  get 'users/tweet_list', to: 'users#tweet_list'
  devise_for :users
  get '/auth/:provider/callback', to: 'users#callback'
end
