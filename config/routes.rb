Rails.application.routes.draw do
  root 'home#top'
  resources :users,only: [:edit,:update]
  resources :tweets,only: [:index,:update,:edit]
  resources :categories,except: [:show]
  resources :post_users, only: [:index,:show]
  patch 'tweets/:id/clip',to:'tweets#toggle_status', as: 'toggle_status'
  get 'users/tweet_fetch', to: 'users#tweet_fetch'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
end
