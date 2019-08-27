Rails.application.routes.draw do
  resources :books
  root 'welcome#index'

  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }

  devise_for :admins

  resources :categories
end
