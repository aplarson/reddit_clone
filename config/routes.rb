Rails.application.routes.draw do
  root to: 'subs#index'

  resources :users
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: [:index] do
    resources :comments, only: [:new]
  end
  resources :comments, only: [:create] do
    resources :comments, only: [:new]
  end
end
