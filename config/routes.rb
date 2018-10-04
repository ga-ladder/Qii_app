Rails.application.routes.draw do
  get 'articles' => 'articles#index'
  get 'show' => 'articles#show'
  get 'organizations' => 'organizations#index'
  get 'organizations/show' => 'organizations#show'
end
