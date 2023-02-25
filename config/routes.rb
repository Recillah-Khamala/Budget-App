Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  get '/index', controller: 'user', action: 'index'
  resources :users
  resources :categories, :path => "categories" do
    resources :expenses, :path => "expenses"
  end
end
