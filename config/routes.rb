BidGate::Application.routes.draw do
  get "sessions/new"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
  
  get "orders/search" => "orders#search"
  # not use the following to avoid duplicate collection paths
  # resources :orders do
     # collection do
      # get :search #, to: 'orders#search', on: :collection
     # end
  # end

  resources :categories, :goods_props, :orders, :order_goods, :order_price_histories

  resources :orders do
    resources :order_goods, :order_price_histories 
  end
  



  get "props_by_category" => "goods_props#props_by_category", :as => "props_by_category"
  
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  get "signup_success" => "users#signup_success", :as => "signup_success"
  
  
  get "user_profile" => "users#profile", :as => "user_profile"
  get "user_edit" => "users#edit", :as => "user_edit"
  get "company/edit" => "companies#edit", :as => "company_edit"
  get "company/verify" => "companies#verify", :as => "company_verify"
  get  "user_new_partial"  => "users#reg_ajax_partial_company_form", :as => "user_new_partial"
  
  #add by Song
  get "order_new" => "orders#new", :as => "orders_new"
  get "order_quickview_show" => "orders#quickview_show", :as => "order_quickview_show"
  #end add
  
  #root :to => "users#new"
  resources :users
  resources :sessions

  #match '/categories', :to => 'categories#index', :as => :index,

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'orders#index'

# See how all your routes lay out with "rake routes"

# This is a legacy wild controller route that's not recommended for RESTful applications.
# Note: This route will make all actions in every controller accessible via GET requests.
# match ':controller(/:action(/:id))(.:format)'
end
