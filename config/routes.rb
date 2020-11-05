Rails.application.routes.draw do
  devise_for :users
  resources :users 
  root to: 'posts#index'
  resources :posts do
    resources :room, only: [:create]
  end
end
