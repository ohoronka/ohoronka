require 'sidekiq/web'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'guarded_objects#index'
  resources :guarded_objects do
    member do
      patch :set_next_status
      get :update_object
    end
  end

  namespace :mobile do
    root to: 'guarded_objects#index'
    resources :guarded_objects, only: [:index, :show] do
      member do
        patch :set_next_status
      end
    end
    get 'sign_in' => 'session#sign_in_form'
    post 'sign_in' => 'session#sign_in'
    get 'logout' => 'session#logout'
  end
  mount Sidekiq::Web => '/admin/sidekiq'
end
