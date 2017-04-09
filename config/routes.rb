Rails.application.routes.draw do
  resources :credits
  resources :tokens
  resources :events, only: [:index, :create]
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
