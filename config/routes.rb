Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :news, only: [:index]

  resources :memberships, except: [:new, :index]

  resources :groups, only: [:index]

  resources :attendances

  resources :events, only: [:show, :index, :edit, :update] do
    collection do
      get :catalog
    end
  end

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

  root 'news#index'
end
