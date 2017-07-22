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

  namespace :admin do
    root to: 'users#index'
    resources :users do
      patch :login_as, on: :member
    end
  end

  namespace :mobile do
    root to: 'facilities#index'
    resources :null, only: [:index, :show] do
      member do
        patch :set_next_status
      end
    end
    get 'sign_in' => 'session#sign_in_form'
    post 'sign_in' => 'session#sign_in'
    get 'sign_out' => 'session#sign_out'
  end
  mount Sidekiq::Web => '/admin/sidekiq'
end
