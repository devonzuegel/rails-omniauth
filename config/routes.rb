Rails.application.routes.draw do
  resource :account, except: %i(new create destroy edit) do
    get 'token', on: :member
  end

  resources :entries do
    get 'freewrite', on: :member
  end

  # Sign-in and authentication.
  root to: 'visitors#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get '/signin'                  => 'sessions#new', as: :signin
  get '/signout'                 => 'sessions#destroy', as: :signout
  get '/auth/failure'            => 'sessions#failure'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :entries, except: %i(new create destroy)
    end
  end
end
