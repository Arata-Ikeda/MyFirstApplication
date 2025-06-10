Rails.application.routes.draw do
  get "coordinates/index"
  get "coordinates/new"
  get "coordinates/show"
  get "home/index"
  root to: "home#index" 

  resources :items
  resources :coordinates
  
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  post 'logout', to: 'sessions#destroy', as: 'logout'

  get 'register', to: 'registrations#new', as: :new_user_registration
  post 'register', to: 'registrations#create', as: :user_registration

  get "up" => "rails/health#show", as: :rails_health_check

  mount Rails.application.routes => '/rails/active_storage'
  
end
