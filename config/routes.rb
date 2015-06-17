Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions', registrations: 'registrations'}

  root to: 'homes#index'
  resource :home, only: :index
  resources :friends, only: [:index, :create]
  patch 'friends/update_status/:user_id', to: 'friends#update_status'
  resources :albums, only: [:index]

  get "*any", to: 'homes#index', constraints: ->(request) { request.format.html? }
end
