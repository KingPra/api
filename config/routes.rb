Rails.application.routes.draw do
  resources :session, only: [:create]
  resources :repos, only: [:index]

  resources :credibility, only: [:index]
  resources :challenges, only: [:index]
  resources :credits
  resources :tokens
  resources :events, only: [:index, :create]
  resources :cred_steps, only: [:index]

  get :settings, to: "users#show"
  put :settings, to: "users#update"

  resources :users, only: [:show] do
    resources :cred_transactions, only: [:index]
  end
end
