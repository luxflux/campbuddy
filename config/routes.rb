Rails.application.routes.draw do
  # START automagic let's encrypt stuff
  if ENV['ACME_KEY'] && ENV['ACME_TOKEN']
    get ".well-known/acme-challenge/#{ENV['ACME_TOKEN']}" => proc { [200, {}, [ ENV["ACME_KEY"] ] ] }
  else
    ENV.each do |var, _|
      next unless var.start_with?('ACME_TOKEN_')
      number = var.sub(/ACME_TOKEN_/, '')
      get ".well-known/acme-challenge/#{ENV["ACME_TOKEN_#{number}"]}" => proc { [200, {}, [ ENV["ACME_KEY_#{number}"] ] ] }
    end
  end
  # END automagic let's encrypt stuff

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
