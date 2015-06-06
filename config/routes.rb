Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'sessions', registrations: 'registrations'}
  root to: 'homes#index'
  resource :home, only: :index
end
