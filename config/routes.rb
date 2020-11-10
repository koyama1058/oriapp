Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resource :good_users, only: [:create, :destroy]
    resource :bad_users, only: [:create, :destroy]
  end

  root to: 'posts#index'
  get 'posts/search'

  resources :posts do 
      member do
        get :chat
        get :chat_destroy
      end
    resources :messages, only: [:index, :create]
    resource :favorites, only: [:create, :destroy]
  end

end
