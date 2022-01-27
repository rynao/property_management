Rails.application.routes.draw do
  root to: 'property#index'
  resources :property
end
