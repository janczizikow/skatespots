Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  get :account, to: 'pages#account'
  scope '/account' do
    get 'reviews', to: 'pages#reviews', as: 'account_reviews'
    get 'spots', to: 'pages#spots', as: 'account_spots'
  end

  resources :favorites, only: :index
  resources :profiles, only: %i[show update]

  resources :spots do
    resources :spots_photos, only: %i[create destroy] #, as: :photos, path: :photos,
    resources :reviews, only: %i[create update destroy]
    resources :favorites, only: %i[create destroy]
  end

  # namespace :api, defaults: { format: :json } do
  #   namespace :v1 do
  #     resources :spots, only: [:index]
  #   end
  # end
end
