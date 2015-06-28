Rails.application.routes.draw do
  resource :account, except: :new
  resources :entries do
    get 'freewrite', on: :member
  end

  # Sign-in and authentication.
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin'                  => 'sessions#new', as: :signin
  get '/signout'                 => 'sessions#destroy', as: :signout
  get '/auth/failure'            => 'sessions#failure'
end
