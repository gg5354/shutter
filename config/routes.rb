Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions', registrations: 'registrations'}

  root to: 'homes#index'
  resource :home, only: :index

  scope constraints: ->(request) { request.format.json? } do
    get 'current_user', to: 'users#show'
    get '/friends', to: 'users#friends'
    resources :relationships, only: [:index, :create, :update, :destroy]
    resources :albums, only: [:index]
  end

  get "*any", to: 'homes#index', constraints: ->(request) { request.format.html? }
end
