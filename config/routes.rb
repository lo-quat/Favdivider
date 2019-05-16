Rails.application.routes.draw do
  resources :users,only: [:edit,:update]
  resources :tweets,only: [:index,:update,:edit]
  resources :categories,only: [:new,:create]
  root 'tweets#index'
  patch 'tweets/:id/clip',to:'tweets#clip', as: 'clip'
  get 'users/tweet_fetch', to: 'users#tweet_fetch'
  get 'post_users', to: 'tweets#post_users'
  get 'post_user_tweets', to: 'tweets#post_user_tweets', as: 'post_user_tweets'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
    #get '/auth/:provider/callback', to: 'users#callback'
end
