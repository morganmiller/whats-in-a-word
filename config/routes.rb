Rails.application.routes.draw do
  root to: 'states#index'

  resources :states, only: [:show, :index]
  resources :legislators, only: [:show]

  get '/auth/twitter', as: 'login'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout', to: "sessions#destroy", as: 'logout'
end
