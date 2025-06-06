Rails.application.routes.draw do
  get "home/index"
  root to: "home#index" 
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  post 'logout', to: 'sessions#destroy', as: 'logout'
 
  get "up" => "rails/health#show", as: :rails_health_check
  
end
