Rails.application.routes.draw do
  root to: "home#index" 

  resources :items
  resources :coordinates
  resources :wishes do
    member do
      patch :purchased_confirm
    end

    collection do
      get :purchased, to: 'wishes#purchased_index'
    end
  end
  
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  delete 'logout', to: 'sessions#destroy', as: 'logout'
  get 'login', to: 'sessions#new', as: :login

  get 'register', to: 'registrations#new', as: :new_user_registration
  post 'register', to: 'registrations#create', as: :user_registration

  get "up" => "rails/health#show", as: :rails_health_check

  mount Rails.application.routes => '/rails/active_storage'
  
end
