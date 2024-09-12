Rails.application.routes.draw do
  resources :category_quotes
  resources :categories
  resources :comments
  resources :quotes
  resources :philosophers
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
