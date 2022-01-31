Rails.application.routes.draw do
  devise_for :users
  root to: 'property#index'
  resources :property do
    resources :rooms, except: :index
  end
  resources :rooms, only: :index
  resources :contracts
  resources :payments

end
