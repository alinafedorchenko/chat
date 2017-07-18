Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root 'users#index'
  resources :users, only: [:index, :show, :edit, :update] do
    resources :messages
  end
end
