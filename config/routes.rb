Rails.application.routes.draw do
  namespace :everybodys do
    get 'tweets/index'
  end
  root 'home#top'
  resources :users, only: %i[edit update]
  resources :tweets, only: %i[index update edit]
  resources :categories, except: [:show]
  resources :post_users, only: %i[index show]
  patch 'tweets/:id/clip', to: 'tweets#toggle_status', as: 'toggle_status'
  get 'users/tweet_fetch', to: 'users#tweet_fetch'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
