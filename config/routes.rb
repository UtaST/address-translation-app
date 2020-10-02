Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
    get 'addresses/edit', to: 'users/registrations#edit_address'
    patch 'addresses/update', to: 'users/registrations#update_address'
    put 'addresses/update', to: 'users/registrations#update_address'
  end
  
  root to: "addresses#index"
  resources :addresses, only: :index do
    collection do
      post 'translate'
    end
  end
end
