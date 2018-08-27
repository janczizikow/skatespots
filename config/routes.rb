Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'
  get :account, to: 'pages#account'
  resources :favorites, only: :index

  namespace :account do
    get :spots, to: 'pages#spots'
  end

  post 'profiles/update', to: 'profiles#update'
  patch 'profiles/update', to: 'profiles#update'
  delete 'profiles/destroy', to: 'profiles#destroy'

  resources :spots do
    resources :spots_photos, only: %i[create destroy] #, as: :photos, path: :photos,
    resources :reviews, only: %i[create destroy]
    resources :favorites, only: %i[create destroy]
  end
end
