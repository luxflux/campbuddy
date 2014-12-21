Rails.application.routes.draw do
  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resource :session, controller: 'sessions', only: [:create] do
    collection do
      post :start_guest
    end
  end

  resources :users, controller: 'clearance/users', only: [:create] do
    resource :password,
      controller: 'clearance/passwords',
      only: [:create, :edit, :update]
  end

  get '/sign_in' => 'sessions#new', as: 'sign_in'
  delete '/sign_out' => 'sessions#destroy', as: 'sign_out'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :news, only: [:index]

  resources :memberships, except: [:new, :index]

  resources :groups, only: [:index]

  resources :attendances, only: [:show, :create, :destroy]

  resources :events, only: [:show, :index, :edit, :update] do
    collection do
      get :catalog
    end
  end

  resources :users, only: [:show, :edit, :update]

  scope '/onboarding', controller: :onboarding, as: :onboarding do
    get 'start/:token', action: :start, as: :start
    post 'finish'
  end

  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  root 'news#index'
end
