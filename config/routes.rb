require 'sidekiq/web'

class AdminConstraint
  def matches?(request)
    return false unless request.session[:user_id]
    user = User.find request.session[:user_id]
    user && user.admin?
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'facilities#index'

  get '/sign_in' => 'sessions#new'
  post '/sign_in' => 'sessions#create'
  delete '/sign_out' => 'sessions#destroy'
  post 'change_version' => 'sessions#change_version'
  resources :facilities do
    member do
      patch :set_next_status
      get :update_facility
    end
    collection do
      get 'shared'
    end
    resources :facility_shares, only: [:new, :create, :destroy, :index]
    resources :devices
    resources :sensors
    resources :events, only: [:index]
  end

  resources :products, only: [:index] do
    member do
      post :to_cart
    end
  end

  resource :cart, only: [:show, :edit, :update] do
    collection do
      get :cities
      get :warehouses
      delete :remove_item
      patch :update_item
    end
  end

  resources :orders

  post 'payment/liqpay' => 'payment/liqpay#index', as: :payment_liqpay

  post '/mobile_devices/set_for_user'

  resources :notifications

  resources :users do
    get 'crop_avatar', on: :member
  end
  resources :channels do
    get 'select_type', on: :collection
  end

  post '/bots/telegram/:bot_token' => 'bots#telegram'

  namespace :admin do
    root to: 'users#index'
    resources :orders
    resources :users do
      patch :login_as, on: :member
    end
  end

  resource :password_reset, only: [:new, :create, :edit, :update]

  get '/test' => 'test#index'

  mount Sidekiq::Web => '/admin/sidekiq', constraints: AdminConstraint.new
end
