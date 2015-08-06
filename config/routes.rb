Rails.application.routes.draw do
  root to: 'states#index'

  resources :states, only: [:show, :index]
end
