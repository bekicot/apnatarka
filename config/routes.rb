Rails.application.routes.draw do


  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "visitors#home"
  resources :menu do
    member do
      get :single_item
    end
    resources :item_chefs do
      collection do
        get :check_chef
        get :remove_cart_item
      end
    end
  end

  resources :address do
    collection do
      post :set_delivery_address
      post :set_delivery_time
    end
  end

  resources :chef_menus, only: [:index] do
    member do
      get :chef_mess_items
      get :mess_request
      get :mess_customise
    end
    collection do
      get :save_customise_mess
    end
  end

  resources :dashboards do
    collection do
      get :get_cities
      post :update_profile
      get :today_mess_detail
    end
  end

  resources :delivery do
    collection do
      get :demo
      get :checkout
      get :add_to_cart
      get :update_quantity
      get :update_special_item_quantity
      get :demo_shopping_cart
      get :demo_checkout
      get :demo_order_received
      post :save_order
      get :add_more_items
      get :add_special_items
      get :guest_order
      get :special_request
      get :set_delivery_mode
      get :save_delivery_mode
      get :new_or_current_address
      post :paytabs_callback
      get :re_payment
      get :all_favorite_orders
      get :get_cities
      get :chef_items
      post :save_special_item
      get :get_special_item
    end
    member do
      get :remove_item
      get :remove_special_item
      get :order_received
      get :add_to_favorite
      get :show_favorite_order
    end
  end
  resources :location, only: [:index, :show]

  resources :visitors, only: [], path: '/' do
    collection do
      get :home
      post :contact_request
      post :change_locale
      get  :feedback
      post :submit_feedback
      get :franchise
      post :submit_franchise
      get :coming_soon
      get :checkemail
      get :login_page
      get :logout_guest
    end
  end

  resources :errors, only: [] do
    collection do
      get :error_404
      get :error_500
    end
  end

  namespace :rider do
    root to: "dashboards#index"
    resources :dashboards, only: [ :index, :show ] do
      member do
        get :deliver_order
        get :accept_order
        get :reject_order
        post :save_reason
      end
      collection do 
        get :rider_history
        get :record_by_date
        get :history_by_date
      end
    end
  end
  namespace :admin do
    root to: "dashboards#index"
    resources :dashboards
    resources :inventory_categories
    resources :chef_mess
    resources :taxes
    resources :special_items
    resources :mess_requests
    resources :measures
    resources :orders do
      collection do
        get :order_items
        get :order_chefs
        get :checkemail
        get :check_cities
        get :add_form_field
        get :menu_item
        get :special_item_price
      end
      member do
        get :order_bill
      end
    end
    resources :mess_items
    resources :chef_menus do
      member do
        get :chef_menu_items
      end
    end
    resources :contact_requests
    resources :users do
      collection do
        get :get_cities
        get :user_roles
        get :record_by_date
        get :chef_inventory_by_date
      end
      member do
        get :order_history
        get :pay_amount
        get :chef_history
      end
      resources :chef_categories do
        resources :chef_category_items  
      end
    end
    resources :categories
    resources :menu_items
    resources :abouts
    resources :locations
    resources :feedbacks
    resources :franchises
    resources :menu_lists

    resources :order_histories, only: [:index, :show] do
      collection do
        get :customer_orders
        get :reg_customer_orders
        get :oder_from_branch
        get :admin_orders
      end
      member do
        post :change_status
        post :rider_payment_status
        get :order_detail
      end
    end

    resources :items
    resources :inventory_items do
      member do
        post :change_status
        get :view_item_detail
      end
      collection do
        get :assign_item
        post :save_assign_item
        get :append_inventory_item
        get :inventory_by_year
      end
    end
  end

   namespace :customer do
    root to: "dashboards#index"
    resources :order_customercustomerhistories, only: [:index, :show]
    resources :users do
      member do
        get :confirm_email
        get :verify_email
      end
    end
  end

  namespace :chef do
    root to: "dashboards#index"
    resources :dashboards do
      member do
        post :change_order_status
        post :change_assigned_item_status
      end
      collection do
        get :order_by_date
        get :chef_inventory
        get :inventory_by_date
      end
    end
    resources :messes
    resources :mess_items
  end
end
