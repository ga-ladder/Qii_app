Rails.application.routes.draw do
  devise_for :users
  root 'articles#index'
  get 'articles' => 'articles#index'
  get 'show' => 'articles#show'
  get 'organizations' => 'organizations#index'
  get 'organizations/show' => 'organizations#show'
end
