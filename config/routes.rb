Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'home#index'

  resources :orders, only: [:new, :create]
  resources :stories, only: [:new, :create, :index, :show, :destroy, :update] do
    collection do
      get :public_story
    end
  end

  resource :profile, only: [:show, :edit, :update]
  resources :subscriptions, only: [:new, :create, :index, :destroy, :update] do
    collection do
      post :checkout
      post :stripe_webhooks
    end
  end

  get '/admin/dashboard', to: 'admin#dashboard', as: 'admin_dashboard'

  

  

end
