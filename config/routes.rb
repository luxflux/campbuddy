Rails.application.routes.draw do
  get 'home' => 'home#index'
  resources :memberships, except: [:new, :index]
  resources :groups
  resources :attendances
  resources :events
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
