CohubTestStore::Application.routes.draw do
  root 'home#index'

  resources :products, only: [:index, :show, :create, :update, :destroy]
end
