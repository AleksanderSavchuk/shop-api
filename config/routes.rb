Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, param: :_username
      resources :products
      post '/login', to: 'authentication#login'
      get '/*a', to: 'application#not_found'
    end
  end
end
