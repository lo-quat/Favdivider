Rails.application.routes.draw do
  resources :users,only: [:edit,:update]
  #get 'users/edit'
  #get 'users/update'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
