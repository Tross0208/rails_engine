Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'api/v1/merchants/find_all', to: 'api/v1/merchants#find_all'
  get 'api/v1/items/find', to: 'api/v1/items#find'
  namespace :api do
    namespace :v1 do
      resources :merchants do
        resources :items, only: [:index]
      end
      resources :items, only: [:index, :show, :create, :delete, :update] do
        resources :merchant, only: [:index]
      end
    end
  end
end
