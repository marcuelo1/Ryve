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
      # Create Product
      put 'schedule', to: 'seller#edit_schedule'
      # List of Products
      get 'list_of_products', to: 'seller#list_of_products'
      # Show Product
      get 'show_product', to: 'seller#show_product'
      # Edit Location
      put 'edit_location', to: 'seller#edit_location'
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
