Rails.application.routes.draw do
 # config/routes.rb
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root 'home#index'
  
  resources :stories, only: [:new, :create, :index, :show, :destroy, :update]
  resource :profile, only: [:show, :edit, :update]
  resources :subscriptions, only: [:new, :create]

  # pour une page statique par exemple:
  get 'home/index', to: 'home#index'
  get 'subscriptions/index'
  post 'subscriptions/index'
  get 'subscriptions/add'
  post 'subscriptions/add'
end
