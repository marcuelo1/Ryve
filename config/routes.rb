Rails.application.routes.draw do

  namespace :v1, default: {format: :json} do
    namespace :seller_user do
      mount_devise_token_auth_for 'Seller', at: 'seller_auth', controllers: {
        registrations: 'v1/seller_user/registrations',
        sessions: 'v1/seller_user/sessions'
      }

      # Verification of seller
      get 'verify', to: 'verification#verify'
      # List of sellers within certain distance
      get 'index', to: 'seller#index'
      # Create Product
      post 'products', to: 'seller#create_product'

    end

    namespace :buyer_user do
      mount_devise_token_auth_for 'Buyer', at: 'buyer_auth', controllers: {
        registrations: 'v1/buyer_user/registrations',
        sessions: 'v1/buyer_user/sessions'
      }

      # Verification of seller
      get 'verify', to: 'verification#verify'
      # List of locations of user
      get 'locations', to: 'buyers#locations'

      get 'products', to: 'buyers#products' 
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
