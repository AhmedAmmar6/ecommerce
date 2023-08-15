Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }
  root 'pages#home'
  resources :stores, only: [:new, :create, :show] do
    resources :products, only: [:new, :create, :show, :index] do
      member do
        post 'buy'
      end
    end
end
  get 'myproducts', to: 'pages#view'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
