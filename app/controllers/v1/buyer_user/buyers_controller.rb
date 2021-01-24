class V1::BuyerUser::BuyersController < ApplicationController
    before_action :authenticate_v1_buyer_user_buyer!

    def products_of_seller
        seller = Seller.find(params[:seller_id])

        products = seller.product_categories.collect do |category|
            {category: category.name, products: category.products}
        end

        render json: products
    end

    def list_of_nearby_stores
        lat = params[:latitude].to_f 
        long = params[:longitude].to_f 
        stores = Seller.where(category: params[:category]).near([lat, long], 50, units: :km)

        render json: stores, status: 200
    end

    def checkout_order
        checkout = CurrentTransaction.new(transaction_params)

        if checkout.save 
            render json: checkout, status: 200
        else
            render json: {errors: checkout.errors}, status: 500
        end
    end

    def update_transaction_status
       transaction = CurrentTransaction.find(params[:checkout_id]) 

       if transaction.update(status: params[:status], time_remaining: params[:time_remaining])
        render json: transaction, status: 200
       else
        render json: {}, status: 500
       end
    end

    def current_transaction
        transaction = CurrentTransaction.find(params[:checkout_id]) 

        render json: transaction, status: 200
    end
    

    private

    def transaction_params
       params.permit(:status, :time_remaining, :is_paid, :product_id, :seller_id, :rider_id) 
    end
    
end
