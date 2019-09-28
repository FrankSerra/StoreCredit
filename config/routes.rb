Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  post "customers/quickAdd"
  get  "customers/export"

  resources :transactions, except: :update
  resources :customers

  root "customers#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
