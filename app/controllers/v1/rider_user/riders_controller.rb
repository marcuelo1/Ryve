class V1::RiderUser::RidersController < ApplicationController
    before_action :authenticate_v1_rider_user_rider!

    def list_of_pending_orders
        lat = params[:latitude].to_f 
        long = params[:longitude].to_f 
        pending_orders = PendingOrder.near([lat, long], 50, units: :km)
        
        render json: pending_orders
    end

    def accept_pending_order
        pending_order = PendingOrder.find(params[:pending_order_id])
        current_transaction = CurrentTransaction.new(transaction_params)
        current_transaction.is_paid = pending_order.is_paid
        current_transaction.buyer = pending_order.buyer
        current_transaction.buyer_location = pending_order.buyer_location
        current_transaction.seller = pending_order.seller
        current_transaction.checkout_order_id = pending_order.checkout_order_id 

        if current_transaction.save 
            pending_order.destroy 

            render json: CurrentTransactionBlueprint.render(current_transaction), status: 200
        else
            render json: {errors: current_transaction.errors}, status: 500
        end
    end

    def current_transaction
        transaction = CurrentTransaction.find(params[:checkout_id]) 

        render json: CurrentTransactionBlueprint.render(transaction), status: 200
    end

    def update_transaction_status
       transaction = CurrentTransaction.find(params[:checkout_id]) 

       if transaction.update(status: params[:status], time_remaining: params[:time_remaining])
        render json: transaction, status: 200
       else
        render json: {}, status: 500
       end
    end

    def complete_transaction
        current = CurrentTransaction.find(params[:checkout_id])

        completed = CompletedTransaction.new(
            checkout_order_id: current.checkout_order_id, 
            rider_id: current.rider_id,
            buyer_id: current.buyer_id,
            seller_id: current.seller_id,
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

    private

    def transaction_params
       params.permit(:status, :time_remaining, :rider_id) 
    end
    
end
