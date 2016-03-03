Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  resource :cart, only: [:show, :destroy, :update] do
    member do
      post :clear
      post :checkout
      post ':book_id' => 'carts#add', as: :add_to
    end
  end

  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :user do
    put 'user' => 'registrations#update_info'
    put 'user/update_password' => 'registrations#update_password'
  end

  resources :orders, only: [:index, :show, :update] do
    resources :checkout, only: [:index, :show, :update]
  end

  resource :home, only: :index
  resources :categories, only: [:index, :show]
  resources :books, only: [:show, :index] do 
    resources :ratings, only: [:new, :create]
  end
  
  resources :authors, only: [:index, :show]

  root to: 'home#index'
end
