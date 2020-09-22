Rails.application.routes.draw do
  devise_for :users

  root to: "addresses#index"
  resources :addresses, only: :index
end
