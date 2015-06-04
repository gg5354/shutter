Rails.application.routes.draw do
  root to: 'homes#index'
  resource :home, only: :index
end
