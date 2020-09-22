Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  root to: "addresses#index"
  resources :addresses, only: :index
end
