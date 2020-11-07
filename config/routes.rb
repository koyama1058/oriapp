Rails.application.routes.draw do
  devise_for :users
  resources :users do
    resource :good_users, only: [:create, :destroy]
  end
  root to: 'posts#index'
  resources :posts do 
      member do
        get :chat
      end
    resources :messages, only: [:index, :create]
    resource :favorites, only: [:create, :destroy]
  end
end
