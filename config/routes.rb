Rails.application.routes.draw do
  resources :session, only: [:create] 
  resources :repos, only: [:index] 

  resources :credibility, only: [:index]
  resources :challenges, only: [:index]
  resources :credits
  resources :tokens
  resources :events, only: [:index, :create]
  resources :cred_steps, only: [:index]

  get :user, to: "users#show"
  put :user, to: "users#update"
end
