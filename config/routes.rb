Rails.application.routes.draw do

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'application#health_check'
  get 'health_check', to: 'application#health_check'
  namespace :api do
    namespace :v1 do
      resources :users
      get 'converter/cidr_to_mask'
      get 'converter/mask_to_cidr'
      post '/auth/login', to: 'authentication#login'
      get '/*a', to: 'application#not_found'
    end
  end
end
