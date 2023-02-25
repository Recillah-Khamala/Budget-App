Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    authenticated :user do
      root 'categories#index', as: :authenticated_root
    end
    unauthenticated do
      root 'users#index', as: :unauthenticated_root
    end
  end

  resources :categories, only: [:index, :new, :create, :show, :destroy] do
    resources :expenses, only: [:index, :new, :create, :show, :destroy]
  end
end
