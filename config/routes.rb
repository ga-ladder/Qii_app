Rails.application.routes.draw do
  # devise_for :users
  devise_for :users, controllers: {
           registrations: "users/registrations",
      omniauth_callbacks: "users/omniauth_callbacks"
      # for reCaptcha
  }
  root 'articles#index'
  resources 'articles', only: [:index, :show]
  resources 'organizations', only: [:index, :show]
  resources 'users'
end
