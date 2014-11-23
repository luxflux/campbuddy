Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  get 'home' => 'home#index'

  resources :memberships, except: [:new, :index]

  resources :groups, only: [:index, :show]

  resources :attendances

  resources :events, only: [:show, :index, :edit, :update]

  resources :users, except: [:index] do
    collection { post :import }
  end

  scope '/onboarding', controller: :onboarding, as: :onboarding do
    get 'start/:token', action: :start, as: :start
    post 'finish'
  end

  if Rails.env.development?
    mount MailPreview => 'mail_view'
  end

  root 'home#index'
end
