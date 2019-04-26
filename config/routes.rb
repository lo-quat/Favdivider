Rails.application.routes.draw do
  resources :users,only: [:edit,:update]
  resources :tweets,only: [:index,:update,:edit]
  resources :categories,only: [:new,:create]
  patch 'tweets/:id/clip',to:'tweets#clip', as: 'clip'
  get 'users/tweet_fetch', to: 'users#tweet_fetch'
  devise_for :users
  get '/auth/:provider/callback', to: 'users#callback'
end
