Rails.application.routes.draw do
  resources :session, only: [:create] 

  resources :credibility, only: [:index]
  resources :challenges, only: [:index]
  resources :credits
  resources :tokens
  resources :events, only: [:index, :create]
  resources :users do
    resources :cred_steps, only: [:index, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
