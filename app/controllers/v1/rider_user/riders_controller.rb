class V1::RiderUser::RidersController < ApplicationController
    before_action :authenticate_v1_rider_user_rider!

    ####    NORMAL TRANSACTIONS
    def list_of_pending_orders
        lat = params[:latitude].to_f 
        long = params[:longitude].to_f 
        buyer_location_ids = BuyerLocation.near([lat, long], 50, units: :km).map{|location| location.id}
        pending_orders = PendingOrder.where(buyer_location_id: buyer_location_ids).map{ |pending_order|
            {
                id: pending_order.id,
                buyer_id: pending_order.buyer_id,
                buyer_location: pending_order.buyer_location,
                seller: pending_order.seller,
                is_paid: pending_order.is_paid,
                amount: CheckoutOrder.find(pending_order.checkout_order_id).amount
            }
        }
        
        render json: pending_orders
    end

    def accept_pending_order
        pending_order = PendingOrder.find(params[:pending_order_id])
        current_transaction = CurrentTransaction.new(transaction_params)
        current_transaction.is_paid = pending_order.is_paid
        current_transaction.buyer = pending_order.buyer
        current_transaction.rider = current_user
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

    ####    UTILITY TRANSACTIONS
    def list_of_pending_utilities
        lat = params[:latitude].to_f 
        long = params[:longitude].to_f 
        utilities = UtilityPending.near([lat, long], 50, units: :km)

        render json: utilities, status: 200
    end

    def accept_utility_pending
        utility = UtilityPending.find(params[:utility_id])
        utility_current = UtilityCurrent.new()
        utility_current.buyer = utility.buyer
        utility_current.rider = current_user 
        utility_current.bill_number = utility.bill_number
        utility_current.provider = utility.provider
        utility_current.type_of_transaction = utility.type_of_transaction
        utility_current.is_paid = utility.is_paid
        utility_current.amount = utility.amount

        if utility_current.save 
            utility.destroy 

            render json: utility, status: 200
        else
            render json: {errors: utility_current.errors}, status: 500
        end
    end
    
    def change_utility_current_status
        utility = UtilityCurrent.find(params[:utility_current_id])

        if utility.update(status: params[:status])
            render json: utility, status: 200
        else
            render json: {errors: utility.errors}, status: 500
        end
    end
    
    private

    def transaction_params
       params.permit(:status, :time_remaining, :rider_id) 
    end
    
end
