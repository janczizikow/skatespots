Rails.application.routes.draw do
  devise_for :users, skip: :edit_user_registration

  root to: 'pages#home'
  get :account, to: 'pages#account'

  scope '/account' do
    get 'spots', to: 'pages#spots', as: 'account_spots'
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :spots, only: [:index]
    end
  end

  resources :favorites, only: :index
  resources :profiles, only: %i[show update destroy]
  # post 'profiles/update', to: 'profiles#update'
  # patch 'profiles/update', to: 'profiles#update'
  # delete 'profiles/destroy', to: 'profiles#destroy'

  resources :spots do
    resources :spots_photos, only: %i[create destroy] #, as: :photos, path: :photos,
    resources :reviews, only: %i[create update destroy]
    resources :favorites, only: %i[create destroy]
  end
end
