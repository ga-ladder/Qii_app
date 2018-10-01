Rails.application.routes.draw do
  get 'articles' => 'articles#index'
  get 'show' => 'articles#show'
end
