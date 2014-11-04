Rails.application.routes.draw do
  get 'home' => 'home#index'
  resources :memberships, except: [:new]
  resources :groups
  resources :attendances
  resources :events
  resources :users, except: [:index] do
    collection { post :import }
  end
  root 'home#index'
end
