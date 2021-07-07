Rails.application.routes.draw do
  get 'likes/create'
  get 'likes/destroy'
  # devise_for :users
  devise_for :users, controllers: {
           registrations: "users/registrations",
      omniauth_callbacks: "users/omniauth_callbacks"
      # for reCaptcha
  }
  root 'articles#index'
  resources 'articles'
  post 'preview_markdown' => 'articles#preview_markdown'
  resources 'organizations', only: [:index, :show]
  resources 'users', only:[:index, :show, :edit, :update, :destroy]

  namespace :settings do
    resources :accounts, only:[:show, :create, :update]
    resources :profiles, only:[:show, :create, :update]
  end

  get '/delete/:id', to: 'settings#delete', as: 'user_delete'

  resources :likes, only: [:create, :destroy]
end
