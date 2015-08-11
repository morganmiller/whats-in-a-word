Rails.application.routes.draw do
  root to: 'welcome#index'

  resources :states, only: [:show, :index]
  resources :legislators, only: [:show]
  resources :quotes, only: [:show]

  get '/auth/twitter', as: 'login'
  get '/auth/twitter/callback', to: 'sessions#create'
  get '/logout', to: "sessions#destroy", as: 'logout'
end
