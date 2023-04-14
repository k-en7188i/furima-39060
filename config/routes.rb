Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items do
    resources :purchase_histories
  end
  # resources :user do
  #   resources :purchase_histories, only: :create
  # end
end