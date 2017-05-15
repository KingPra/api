Rails.application.routes.draw do
  resources :session, only: [:create]
  resources :repos, only: [:index]

  resources :credibility, only: [:index]
  resources :challenges, only: [:index]
  resources :credits
  resources :tokens
  resources :github_webhooks, only: :create
  resources :events, only: [:index, :create]

  get :settings, to: "users#show"
  put :settings, to: "users#update"

  resources :users, only: [:index, :show] do
    resources :cred_transactions, only: [:index]
  end

  if Rails.env.development?
    require 'sidekiq/web'
    Sidekiq::Web.set :session_secret, Rails.application.secrets[:secret_key_base]
    mount Sidekiq::Web => '/sidekiq'
  end
end
