Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'home#index'

  resources :orders, only: [:new, :create]
  resources :stories, only: [:new, :create, :index, :show, :destroy, :update]
  resource :profile, only: [:show, :edit, :update]
  resources :subscriptions, only: [:new, :create, :index, :destroy, :update]

  # Pour une page statique par exemple:
  get 'admin/dashboard'
end
