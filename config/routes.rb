Rails.application.routes.draw do
  authenticate :admin_user do
    namespace :admin do
      resources :users
      resources :admin_users
      resources :books
      resources :categories

      root to: "admin_users#index"
      end
  end

  root 'welcome#index'

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  devise_for :admin_users

  resources :categories, only: [:index, :show]

  resources :books do
    member do
      get :toggle_status
      get :assign
    end
  end
end
