Rails.application.routes.draw do
  get 'home' => 'home#index'
  resources :memberships
  resources :groups
  resources :attendances
  resources :events
  resources :users do
    collection { post :import }
  end
  root 'home#index'
  
end
