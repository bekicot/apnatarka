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
    resources :item_chefs
  end

  resources :address do
    collection do
      post :set_delivery_address
      post :set_delivery_time
    end
  end

  resources :delivery do
    collection do
      get :demo
      get :checkout
      get :add_to_cart
      get :update_quantity
      get :demo_shopping_cart
      get :demo_checkout
      get :demo_order_received
      post :save_order
      get :add_more_items
      get :guest_order
      get :special_request
      get :set_delivery_mode
      get :save_delivery_mode
      get :new_or_current_address
      post :paytabs_callback
      get :re_payment
      get :all_favorite_orders
    end
    member do
      get :remove_item
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

  namespace :admin do
    root to: "dashboards#index"
    resources :dashboards
    resources :chef_mess
    resources :chef_mess_items
    resources :chef_menus do
      member do
        get :chef_menu_items
      end
    end
    resources :contact_requests
    resources :users do
      collection do
        get :get_cities
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
      end
      member do
        post :change_status
      end
    end
  end

   namespace :customer do
    root to: "dashboards#index"
    resources :order_histories, only: [:index, :show]
    resources :users do
      member do
        get :confirm_email
        get :verify_email
      end
    end
  end
end
