Rails.application.routes.draw do
  resources :jobs
  resources :memberships
  resources :groups
  resources :attendances
  resources :workshops
  resources :users do
    collection { post :import }
  end

  root 'workshops#index'
end
