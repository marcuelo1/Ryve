Rails.application.routes.draw do

  namespace :v1, default: {format: :json} do
    namespace :seller_user do
      mount_devise_token_auth_for 'Seller', at: 'seller_auth', controllers: {
        registrations: 'v1/seller_user/registrations',
        sessions: 'v1/seller_user/sessions'
      }

      # Verification of seller
      get 'verify', to: 'verification#verify'
      #########################################################################################################
      ####
      ####  SELLER PROFILE
      ####
      # Edit Location
      put 'edit_location', to: 'seller#edit_location'
      # Post Profile Image
      post 'post_profile_image', to: 'seller#post_profile_image'
      # Update Profile Image
      put 'edit_profile_image', to: 'seller#edit_profile_image'
      # Post Profile Image
      post 'post_background_image', to: 'seller#post_background_image'
      # Update Profile Image
      put 'edit_background_image', to: 'seller#edit_background_image'
      #########################################################################################################
      ####
      ####  SELLER PRODUCTS
      ####
      # Create Product
      post 'products', to: 'seller#create_product'
      # Update Product Image
      put 'edit_product_image', to: 'seller#edit_product_image'
      # Update Product Availability
      put 'edit_product_availability', to: 'seller#edit_product_availability'
      # Create Product
      put 'schedule', to: 'seller#edit_schedule'
      # List of Products
      get 'list_of_products', to: 'seller#list_of_products'
      # Show Product
      get 'show_product', to: 'seller#show_product'
      #########################################################################################################
      ####
      ####  TRANSACTIONS
      ####
      # List of Current Transactions
      get 'list_of_current_transactions', to: 'seller#list_of_current_transactions'
      # List of Completed Transactions
      get 'list_of_completed_transactions', to: 'seller#list_of_completed_transactions'
      #########################################################################################################
    end

    namespace :buyer_user do
      mount_devise_token_auth_for 'Buyer', at: 'buyer_auth', controllers: {
        registrations: 'v1/buyer_user/registrations',
        sessions: 'v1/buyer_user/sessions'
      }

      # Verification of seller
      get 'verify', to: 'verification#verify'
      #########################################################################################################
      ####
      ####  BUYER'S PROFILE
      ####
      # Add Location
      post 'add_location', to: 'buyers#add_location'
      # Edit Location
      put 'edit_location', to: 'buyers#edit_location'
      #########################################################################################################
      ####
      ####  STORES
      ####
      # List of Nearby Stores
      get 'list_of_nearby_stores', to: 'buyers#list_of_nearby_stores'
      # List of products of the seller
      get 'products_of_seller', to: 'buyers#products_of_seller' 
      # Add to Cart
      post 'add_to_cart', to: 'buyers#add_to_cart'
      #########################################################################################################
      ####
      ####  BUYER'S TRANSACTIONS
      ####
      # Checkout Order
      post 'checkout_order', to: 'buyers#checkout_order'
      # Current Transaction
      get 'current_transaction', to: 'buyers#current_transaction'
      # History List of Transactions
      get 'history_list_of_checkouts', to: 'buyers#history_list_of_checkouts'
      #########################################################################################################
      ####
      #### UTILITY
      ####
      # Utility Checkout
      post 'checkout_utility_transaction', to: 'buyers#checkout_utility_transaction'
      # Show Utility Current Transaction
      get 'show_utility_current', to: 'buyers#show_utility_current'
      # List of Utility Completed Transactions
      get 'list_of_completed_utilities', to: 'buyers#list_of_completed_utilities'
    end

    namespace :rider_user do
      mount_devise_token_auth_for 'Rider', at: 'rider_auth', controllers: {
        registrations: 'v1/rider_user/registrations',
        sessions: 'v1/rider_user/sessions'
      }

      # Verification of seller
      get 'verify', to: 'verification#verify'
      #########################################################################################################
      ####
      #### NORMAL TRANSACTIONS
      ####
      # List of Pending Orders
      get 'list_of_pending_orders', to: 'riders#list_of_pending_orders'
      # Accept Pending Order
      post 'accept_pending_order', to: 'riders#accept_pending_order'
      # Update Transaction Status
      put 'update_transaction_status', to: 'riders#update_transaction_status'
      # Current Transaction
      get 'current_transaction', to: 'riders#current_transaction'
      # Complete a transaction
      post 'complete_transaction', to: 'riders#complete_transaction'
      #########################################################################################################
      ####
      ####  UTILITY TRANSACTIONS
      ####
      # List of Utility Pendings
      get 'list_of_pending_utilities', to: 'riders#list_of_pending_utilities'
      # Accept Utility 
      post 'accept_utility_pending', to: 'riders#accept_utility_pending'
      # Change Utility Current Transaction
      put 'change_utility_current_status', to: 'riders#change_utility_current_status'
    end
  end
end
