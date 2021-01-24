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

    def complete_transaction
        current = CurrentTransaction.find(params[:checkout_id])

        completed = CompletedTransaction.new(
            product_id: current.product_id, 
            rider_id: current.rider_id,
            buyer_id: current.buyer_id,
            buyer_location_id: current.buyer_location_id,
            date: Time.now
        )

        if completed.save 
            current.destroy
            render json: completed, status: 200
        else
            render json: {errors: completed.errors}, status: 500
        end
    end
    
    def history_list_of_checkouts
        transactions = CompletedTransaction.where(buyer: current_user)

        render json: transactions, status: 200
    end

    def add_location
        location = current_user.buyer_locations.new(location_params)

        if location.save 
            render json: location, status: 200
        else 
            render json: {errors: location.errors}, status: 500
        end
    end
    

    private

    def transaction_params
       params.permit(:status, :time_remaining, :is_paid, :buyer_id, :product_id, :rider_id, :buyer_location_id) 
    end

    def location_params
        params.permit(:longitude, :latitude, :name)
    end
    
    
end
