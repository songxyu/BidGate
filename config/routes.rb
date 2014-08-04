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
  
  get "dashboard/dashboard" => "users#dashboard", :as => "dashboard" # account info
  get "dashboard/dashboard_purchases" => "orders#dashboard_purchase_orders", :as => "dashboard_purchases"
  get "dashboard/dashboard_purchases_all" => "orders#dashboard_purchase_orders_all", :as => "dashboard_purchases_all"
  get "dashboard/dashboard_purchases_forpaid" => "orders#dashboard_purchase_orders_forpaid", :as => "dashboard_purchases_forpaid"
  get "dashboard/dashboard_purchases_complete" => "orders#dashboard_purchase_orders_complete", :as => "dashboard_purchases_complete"
  get "dashboard/dashboard_purchases_bidding" => "orders#dashboard_purchase_orders_bidding", :as => "dashboard_purchases_bidding"
  get "dashboard/dashboard_purchases_closed" => "orders#dashboard_purchase_orders_closed", :as => "dashboard_purchases_closed"

  get "dashboard/dashboard_vendings" => "orders#dashboard_vending_orders", :as => "dashboard_vendings"
  get "dashboard/dashboard_vendings_all" => "orders#dashboard_vending_orders_all", :as => "dashboard_vendings_all"
  get "dashboard/dashboard_vendings_dealed" => "orders#dashboard_vending_orders_dealed", :as => "dashboard_vendings_dealed"
  get "dashboard/dashboard_vendings_complete" => "orders#dashboard_vending_orders_complete", :as => "dashboard_vendings_complete"
  get "dashboard/dashboard_vendings_bidding" => "orders#dashboard_vending_orders_bidding", :as => "dashboard_vendings_bidding"
  get "dashboard/dashboard_vendings_biddingfail" => "orders#dashboard_vending_orders_fail_bidding", :as => "dashboard_vendings_biddingfail"
  
  get "dashboard/dashboard_msg" => "users#dashboard_msg", :as => "dashboard_msg"
  get "dashboard/dashboard_settings" => "users#dashboard_settings", :as => "dashboard_settings"
  post "dashboard/changepw" => "users#change_password", :as => "change_password"
  get "dashboard/edit_profile" => "users#edit", :as => "edit_profile"
  get "dashboard/edit_company" => "companies#edit", :as => "edit_company"
  #put "users/:id" => "users#update", :as => "update_profile"
  
  
  put "orders/approve_bid" => "orders#approve_bid", :as => "approve_bid"
  put "orders/cancel_bid" => "orders#cancel_bid", :as => "cancel_bid"
  put "orders/reopen_bid" => "orders#reopen_bid", :as => "reopen_bid"

  get "cancel_bid_dialog" =>"orders#cancel_bid_dialog", :as => "cancel_bid_dialog"

  
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
  get "category_list" => "categories#category_list", :as => "category_list"
  get "category_unit" => "categories#category_unit", :as => "category_unit"
  get "logout" => "sessions#destroy", :as => "logout"
  
  # login dialog
  get "login" => "sessions#new", :as => "login"
  # login page
  get "logon" => "sessions#new_2", :as => "logon"
  
  get "signup" => "users#new", :as => "signup"
  get "register_details" => "users#new", :as => "register_details"
  get "signup_success" => "users#signup_success", :as => "signup_success"
  
  
  get "user_profile" => "users#profile", :as => "user_profile"
  get "user_edit" => "users#edit", :as => "user_edit"
  get "company/edit" => "companies#edit", :as => "company_edit"
  get "company/verify" => "companies#verify", :as => "company_verify"
  put "company/:id" => "companies#update", :as => "company_update"
  get  "user_new_partial"  => "users#reg_ajax_partial_company_form", :as => "user_new_partial"
  
  #add by Song
  get "order_new" => "orders#new", :as => "orders_new"
  get "order_quickview_show" => "orders#quickview_show", :as => "order_quickview_show"
  get "comm_dialog_show" => "orders#comm_dialog_show", :as => "comm_dialog_show"
  get "bid_dialog_show" =>"orders#bid_dialog_show", :as => "bid_dialog_show"
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
  root :to => 'application#home'

# See how all your routes lay out with "rake routes"

# This is a legacy wild controller route that's not recommended for RESTful applications.
# Note: This route will make all actions in every controller accessible via GET requests.
# match ':controller(/:action(/:id))(.:format)'
end
