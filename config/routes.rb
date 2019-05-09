Rails.application.routes.draw do
  resources :users,only: [:edit,:update]
  resources :tweets,only: [:index,:update,:edit]
  resources :categories,only: [:new,:create]
  patch 'tweets/:id/clip',to:'tweets#clip', as: 'clip'
  get 'users/tweet_fetch', to: 'users#tweet_fetch'
  get 'tweets/post_users', to: 'tweets#post_users'
  get 'tweets/post_users/post_user_tweets', to: 'tweets#post_user_tweets', as: 'post_user_tweets'
  devise_for :users
  get '/auth/:provider/callback', to: 'users#callback'
end
