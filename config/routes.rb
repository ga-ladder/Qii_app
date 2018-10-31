Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
      omniauth_callbacks: "users/omniauth_callbacks"
  }
  root 'articles#index'
  resources 'articles', only: [:index, :show]
  resources 'organizations', only: [:index, :show]
  resources 'users'
end
