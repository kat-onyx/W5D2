Rails.application.routes.draw do

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :posts do
    resources :comments, only: [:new, :create]
  end
  resources :comments, only: [:show]
  resources :subs
  resources :posts, except: [:index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
