Rails.application.routes.draw do
  use_doorkeeper

  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resource :session, controller: 'sessions', only: [:create] do
    collection do
      post :start_guest
    end
  end

  resources :users, only: [:new, :create, :show, :edit, :update] do
    resource :password,
      controller: 'clearance/passwords',
      only: [:create, :edit, :update]
  end

  get '/sign_in' => 'sessions#new', as: 'sign_in'
  delete '/sign_out' => 'sessions#destroy', as: 'sign_out'
  get '/sign_up' => 'users#new', as: 'sign_up'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount CampBuddy::API => '/api'

  resources :news, only: [:index]

  resources :emergency_numbers, only: [:index]

  resources :maps, only: [:index]

  resources :memberships, except: [:new, :index]

  resources :groups, only: [:index]

  resources :attendances, only: [:show, :create, :destroy]

  resources :events, only: [:show, :index, :edit, :update] do
    collection do
      get :catalog
    end
  end

  scope '/onboarding', controller: :onboarding, as: :onboarding do
    get 'start/:token', action: :start, as: :start
    post 'finish'
  end

  get 'offline', to: 'offline#show'

  root 'root#show'
end
