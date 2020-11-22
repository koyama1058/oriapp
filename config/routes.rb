Rails.application.routes.draw do
  devise_for :users

  resources :users do
    resource :good_users, only: %i[create destroy]
    resource :bad_users, only: %i[create destroy]
  end

  root to: 'posts#index'
  get 'posts/search'
  resources :tags, only: [:show]

  resources :posts do
    member do
      get :chat
      get :chat_destroy
    end
    resources :messages, only: %i[index create destroy]
    resource :favorites, only: %i[create destroy]
  end
end
