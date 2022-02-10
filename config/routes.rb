Rails.application.routes.draw do
  devise_for :users
  root to: 'property#summary'
  resources :property do
    resources :rooms, except: :index
    collection do
      get 'summary'
    end
  end
  resources :rooms, only: :index
  resources :contracts
  resources :payments
  get 'get_rooms', to: 'application#get_rooms'
  get 'get_contracts', to: 'application#get_contracts'
end
