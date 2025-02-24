Rails.application.routes.draw do
  devise_for :users
  resources :appointments
  resources :clients do
    resources :addresses, only: %i[new create edit update destroy]
  end
  resources :locations do
    resources :addresses, only: %i[new create edit update destroy]
  end
  # resources :users

  root "appointments#index"
end
