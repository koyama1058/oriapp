Rails.application.routes.draw do
  devise_for :users
  resources :users 
  root to: 'posts#index'
  resources :posts 
end
