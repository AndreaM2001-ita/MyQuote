Rails.application.routes.draw do
  get 'search/index'
  #get 'home/index'
    
  resources :philosophers
  resources :users
  resources :category_quotes
  resources :categories

  resources :quotes do
    resources :comments
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'about', to: 'about#index'  #about page

  get 'search', to: 'search#index'  #search page


  get 'login', to:'sessions#new'  #new login

  post 'login', to:'sessions#create' #create session

  delete 'logout', to: 'sessions#destroy'  #logout

  get '/admin', to: 'home#aindex'  #admin home page

  get '/userhome', to: 'home#uindex'  #user homepage

  get '/quotes', to: 'home#uquotes'  #quotes of current user

  get '/change_password', to: 'users#change_password' #get page to change pasw

  patch '/change_password', to: 'users#update_password' #patch the current password



  # Defines the root path route ("/")
  root "home#index"
  #about "about#index"
end
