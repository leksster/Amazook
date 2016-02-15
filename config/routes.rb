Rails.application.routes.draw do
  get 'cart' => 'cart#index'
  post 'cart/destroy' => 'cart#destroy'
  post 'cart/clear' => 'cart#clear'
  post 'cart/checkout' => 'cart#checkout'
  post 'cart/update' => 'cart#update'  


  resource :address, only: [:edit, :update]


  devise_for :users, :controllers => { registrations: 'registrations', omniauth_callbacks: 'omniauth_callbacks' }

  resources :users do   
    patch 'update_billing', on: :member
    patch 'update_shipping', on: :member
    patch 'update_password', on: :member
    patch 'update_email', on: :member
    resources :orders do
      resource :credit_card, only: [:edit, :update]
      resources :shippings, only: [:index, :update]
      resource :address, only: [:shipping, :update, :edit] do
        post 'addshipping', on: :member
        get 'editshipping' => 'addresses#editshipping'
      end

      get 'completed', on: :member
    end
  end  


  resources :home, only: :index

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :books, only: [:index, :show] do 
    get 'cart/add' => 'cart#add'
    resources :ratings, only: [:show, :new, :create, :edit]
  end
  
  resources :categories, only: [:index, :show]
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
