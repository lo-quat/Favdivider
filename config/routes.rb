Rails.application.routes.draw do
  namespace :everybodys do
    resources :tweets, only: %i[index]
    resources :categories, only: %i[index show]
    resources :users, only: %i[index show]
  end
  root 'home#top'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get 'users/tweet_fetch', to: 'users#tweet_fetch'
  resources :users, only: %i[edit show update destroy]
  resources :tweets, only: %i[index update edit]
  resources :categories, except: [:show]
  resources :post_users, only: %i[index show]
  patch 'tweets/:id/clip', to: 'tweets#toggle_status', as: 'toggle_status'
  patch 'categories/category_publish/:id', to: 'categories#category_publish', as: 'category_publish'
  get 'tweets/hashtag', to: 'tweets#hashtag'
end
