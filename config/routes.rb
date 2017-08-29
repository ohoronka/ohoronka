require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'facilities#index'

  get '/sign_in' => 'sessions#new'
  post '/sign_in' => 'sessions#create'
  delete '/sign_out' => 'sessions#destroy'

  resources :facilities do
    member do
      patch :set_next_status
      get :update_facility
    end
    resources :devices do
      resources :sensors, except: [:index]
    end
    resources :sensors, only: [:index] do
      get :select_device, on: :collection
    end
    resources :events, only: [:index]
  end

  resources :friends do
    collection do
      get 'find'
      get 'requests'
    end
    member do
      post 'add'
      post 'accept'
      delete 'reject'
    end
  end

  resources :users do
    get 'crop_avatar', on: :member
  end
  resources :channels do
    get 'select_type', on: :collection
  end

  post '/bots/telegram/:bot_token' => 'bots#telegram'

  namespace :admin do
    root to: 'users#index'
    resources :users do
      patch :login_as, on: :member
    end
  end

  get '/test' => 'test#index'

  mount Sidekiq::Web => '/admin/sidekiq'
end
