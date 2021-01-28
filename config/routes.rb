Rails.application.routes.draw do

  namespace :v1, default: {format: :json} do
    namespace :seller_user do
      mount_devise_token_auth_for 'Seller', at: 'seller_auth', controllers: {
        registrations: 'v1/seller_user/registrations',
        sessions: 'v1/seller_user/sessions'
      }

      # Verification of seller
      get 'verify', to: 'verification#verify'
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
      # Edit Location
      put 'edit_location', to: 'seller#edit_location'
      # List of Current Transactions
      get 'list_of_current_transactions', to: 'seller#list_of_current_transactions'
      # List of Completed Transactions
      get 'list_of_completed_transactions', to: 'seller#list_of_completed_transactions'
      # Post Profile Image
      post 'post_profile_image', to: 'seller#post_profile_image'
      # Update Profile Image
      put 'edit_profile_image', to: 'seller#edit_profile_image'
      # Post Profile Image
      post 'post_background_image', to: 'seller#post_background_image'
      # Update Profile Image
      put 'edit_background_image', to: 'seller#edit_background_image'
    end

    namespace :buyer_user do
      mount_devise_token_auth_for 'Buyer', at: 'buyer_auth', controllers: {
        registrations: 'v1/buyer_user/registrations',
        sessions: 'v1/buyer_user/sessions'
      }

      # Verification of seller
      get 'verify', to: 'verification#verify'

      # List of products of the seller
      get 'products_of_seller', to: 'buyers#products_of_seller' 
      # List of Nearby Stores
      get 'list_of_nearby_stores', to: 'buyers#list_of_nearby_stores'
      # Checkout Order
      post 'checkout_order', to: 'buyers#checkout_order'
      # Update Transaction Status
      put 'update_transaction_status', to: 'buyers#update_transaction_status'
      # Current Transaction
      get 'current_transaction', to: 'buyers#current_transaction'
      # Complete a transaction
      post 'complete_transaction', to: 'buyers#complete_transaction'
      # History List of Transactions
      get 'history_list_of_checkouts', to: 'buyers#history_list_of_checkouts'
      # Add Location
      post 'add_location', to: 'buyers#add_location'
      # Edit Location
      put 'edit_location', to: 'buyers#edit_location'
      # Add to Cart
      post 'add_to_cart', to: 'buyers#add_to_cart'
    end

    namespace :rider_user do
      mount_devise_token_auth_for 'Rider', at: 'rider_auth', controllers: {
        registrations: 'v1/rider_user/registrations',
        sessions: 'v1/rider_user/sessions'
      }

      # Verification of seller
      get 'verify', to: 'verification#verify'

      get 'test', to: 'riders#test'
    end
  end
end
