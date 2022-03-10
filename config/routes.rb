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
  get 'get_building_rents', to: 'property#get_building_rents'
  get 'get_rooms', to: 'application#get_rooms'
  get 'get_contracts', to: 'application#get_contracts'
  get 'get_amounts', to: 'application#get_amounts'
  get 'get_copy_contracts', to: 'application#get_copy_contracts'
end
