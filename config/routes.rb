Rails.application.routes.draw do
  namespace :everybodys do
    resources :tweets, only: %i[index]
    resources :categories, only: %i[index show]
  end
  root 'home#top'
  resources :users, only: %i[edit update destroy]
  resources :tweets, only: %i[index update edit]
  resources :categories, except: [:show]
  resources :post_users, only: %i[index show]
  patch 'tweets/:id/clip', to: 'tweets#toggle_status', as: 'toggle_status'
  get 'users/tweet_fetch', to: 'users#tweet_fetch'
  patch 'categories/category_publish/:id', to: 'categories#category_publish', as: 'category_publish'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
