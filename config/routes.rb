Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resource :cart, only: [:show, :destroy, :update] do
    post 'clear' => 'carts#clear'
    post 'checkout' => 'carts#checkout'
  end

  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :user do   
    get 'user/edit', :to => 'registrations#edit'
    patch 'user/update_billing', :to => 'registrations#update_billing'
    patch 'user/update_shipping', :to => 'registrations#update_shipping'
    patch 'user/update_password', :to => 'registrations#update_password'
    patch 'user/update_email', :to => 'registrations#update_email'
  end

  resources :orders, only: [:index, :show, :update] do
    resources :checkout, only: [:index, :show, :update]
  end

  resources :home, only: :index
  resources :categories, only: [:index, :show]
  resources :books, only: [:show, :index] do 
    post 'cart/add' => 'carts#add'
    resources :ratings, only: [:show, :new, :create, :edit]
  end
  
  resources :authors, only: [:index, :show]

  root to: 'home#index'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
