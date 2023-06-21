Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'home#index'

  resources :orders, only: [:new, :create]
  resources :stories, only: [:new, :create, :index, :show, :destroy, :update, :public_story]
  resource :profile, only: [:show, :edit, :update]
  resources :subscriptions, only: [:new, :create, :index, :destroy, :update]

  # Pour une page statique par exemple:
  get 'admin/dashboard'
  get 'public_story', to: 'stories#public_story', as: 'public_story'

  # Stripe
  post 'subscriptions/checkout', to: 'subscriptions#checkout', as: 'checkout_subscriptions'
  post 'stripe_webhooks', to: 'subscriptions#stripe_webhooks'


end