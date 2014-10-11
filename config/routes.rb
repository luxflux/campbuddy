Rails.application.routes.draw do
  resources :memberships
  resources :groups
  resources :attendances
  resources :events
  resources :users do
    collection { post :import }
  end

  root 'workshops#index'
end
