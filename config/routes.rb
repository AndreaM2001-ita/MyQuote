Rails.application.routes.draw do
  #get 'home/index'
  resources :category_quotes
  resources :categories
  resources :comments
  resources :quotes
  resources :philosophers
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'about', to: 'about#index'
  # Defines the root path route ("/")
  root "home#index"
  #about "about#index"
end
