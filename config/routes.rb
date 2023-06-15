Rails.application.routes.draw do
  devise_for :users
  root 'home#index'
  
  resources :stories, only: [:new, :create, :index, :show, :destroy, :update]
  resource :profile, only: [:show, :edit, :update]
  resources :subscriptions, only: [:new, :create]

  # pour une page statique par exemple:
  get 'home/index', to: 'home#index'
end
