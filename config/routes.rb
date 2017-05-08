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
  mount Sidekiq::Web => '/admin/sidekiq'
end
