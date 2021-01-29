class V1::BuyerUser::BuyersController < ApplicationController
    before_action :authenticate_v1_buyer_user_buyer!

    ####    STORES
    def list_of_nearby_stores
        lat = params[:latitude].to_f 
        long = params[:longitude].to_f 
        stores = Seller.where(category: params[:category]).near([lat, long], 50, units: :km)

        render json: stores, status: 200
    end

    def products_of_seller
        seller = Seller.find(params[:seller_id])

        products = seller.product_categories.collect do |category|
            {category: category.name, products: category.products}
        end

        render json: products
    end

    def add_to_cart
        product = Product.find(params[:product_id])
        seller = product.product_category.seller
        cart = Cart.where(buyer: current_user, seller: seller).first_or_create

        if cart.checkout_order_id == nil 
            checkout_order = CheckoutOrder.create()
            cart.checkout_order_id = checkout_order.id 
            cart.save 

            checkout_product = checkout_order.checkout_products.create(product_id: params[:product_id], quantity: params[:quantity])
        else
            checkout_order = CheckoutOrder.find(cart.checkout_order_id)
            checkout_product = checkout_order.checkout_products.where(product_id: params[:product_id]).first 

            if checkout_product 
                product_current_quantity = checkout_product.quantity
                checkout_product.update(quantity: product_current_quantity + params[:quantity].to_i)
            else
                checkout_product = checkout_order.checkout_products.create(product_id: params[:product_id], quantity: params[:quantity])
            end
        end

        render json: CartBlueprint.render(cart)
    end

    ####    TRANSACTIONS
    def checkout_order
        pending_order = PendingOrder.new(buyer: current_user, is_paid: params[:is_paid], buyer_location_id: params[:buyer_location_id])
        cart = Cart.find(params[:cart_id])
        pending_order.seller = cart.seller
        pending_order.checkout_order_id = cart.checkout_order_id

        if pending_order.save 
            cart.destroy

            render json: pending_order, status: 200
        else
            render json: {errors: pending_order.errors}, status: 500
        end
    end

    def current_transaction
        transaction = CurrentTransaction.find(params[:checkout_id]) 

        render json: CurrentTransactionBlueprint.render(transaction), status: 200
    end
    
    def history_list_of_checkouts
        transactions = CompletedTransaction.where(buyer: current_user)

        render json: CompletedTransactionBlueprint.render(transactions), status: 200
    end

    ####    LOCATIONS
    def add_location
        location = current_user.buyer_locations.new(location_params)

        if location.save 
            render json: location, status: 200
        else 
            render json: {errors: location.errors}, status: 500
        end
    end
    
    def edit_location
        location = BuyerLocation.find(params[:location_id])

        if location.update(location_params)
            render json: location, status: 200
        else
            render json: {errors: location.errors}, status: 500
        end
    end

    ####    ELECTRICITY
    def checkout_electricity_transaction
        electricity_transaction = ElecCurrTransaction.new(electricity_transaction_params)
        
        if electricity_transaction.save 
            render json: electricity_transaction, status: 200
        else
            render json: {errors: electricity_transaction.errors}, status: 500
        end
    end

    def change_electricity_current_transaction_status
        electricity_transaction = ElecCurrTransaction.find(params[:electricity_current_transaction_id])

        if electricity_transaction.update(status: params[:status])
            render json: electricity_transaction, status: 200
        else
            render json: {errors: electricity_transaction.errors}, status: 500
        end
    end

    def show_electricity_current_transaction
        electricity_transaction = ElecCurrTransaction.find(params[:electricity_current_transaction_id])
        render json: electricity_transaction, status: 200
    end
    
    def complete_electricity_current_transaction
        electricity_current_transaction = ElecCurrTransaction.find(params[:electricity_current_transaction_id])
        electricity_completed_transaction = ElecCompTransaction.new(
            buyer_id: electricity_current_transaction.buyer_id,
            rider_id: electricity_current_transaction.rider_id,
            electricity_provider_id: electricity_current_transaction.electricity_provider_id,
            electricity_bill_number: electricity_current_transaction.electricity_bill_number,
            date_transacted: electricity_current_transaction.created_at,
            type_of_transaction: electricity_current_transaction.type_of_transaction,
            date_paid: Time.now,
            amount: electricity_current_transaction.amount,
        )

        if electricity_completed_transaction.save 
            render json: electricity_completed_transaction, status: 200
        else
            render json: {errors: electricity_completed_transaction.errors}, status: 500
        end
    end

    ####    WATER
    def checkout_water_transaction
        water_transaction = WaterCurrTransaction.new(water_transaction_params)
        
        if water_transaction.save 
            render json: water_transaction, status: 200
        else
            render json: {errors: water_transaction.errors}, status: 500
        end
    end

    def change_water_current_transaction_status
        water_transaction = WaterCurrTransaction.find(params[:water_current_transaction_id])

        if water_transaction.update(status: params[:status])
            render json: water_transaction, status: 200
        else
            render json: {errors: water_transaction.errors}, status: 500
        end
    end

    def show_water_current_transaction
        water_transaction = WaterCurrTransaction.find(params[:water_current_transaction_id])
        render json: water_transaction, status: 200
    end
    
    def complete_water_current_transaction
        water_current_transaction = WaterCurrTransaction.find(params[:water_current_transaction_id])
        water_completed_transaction = WaterCompTransaction.new(
            buyer_id: water_current_transaction.buyer_id,
            rider_id: water_current_transaction.rider_id,
            electricity_provider_id: water_current_transaction.electricity_provider_id,
            electricity_bill_number: water_current_transaction.electricity_bill_number,
            date_transacted: water_current_transaction.created_at,
            type_of_transaction: water_current_transaction.type_of_transaction,
            date_paid: Time.now,
            amount: water_current_transaction.amount,
        )

        if water_completed_transaction.save 
            render json: water_completed_transaction, status: 200
        else
            render json: {errors: water_completed_transaction.errors}, status: 500
        end
    end

    private

    def location_params
        params.permit(:longitude, :latitude, :name)
    end

    def electricity_transaction_params
        params.permit(:buyer_id, :rider_id, :electricity_provider_id, :electricity_bill_number, :status, :type_of_transaction, :is_paid, :amount)
    end

    def water_transaction_params
        params.permit(:buyer_id, :rider_id, :water_provider_id, :water_bill_number, :status, :type_of_transaction, :is_paid, :amount)
    end
end