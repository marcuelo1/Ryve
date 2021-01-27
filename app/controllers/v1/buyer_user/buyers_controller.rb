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
        transaction = CurrentTransaction.new(transaction_params)
        transaction.seller = Seller.find(Product.find(params[:products][0]).product_category.seller_id)

        if transaction.save 
            checkout = CheckoutOrder.create()
            transaction.checkout_order_id = checkout.id 
            transaction.save

            params[:products].each_with_index do |product, index|
                CheckoutProduct.create(
                    product_id: product.to_i,
                    checkout_order_id: checkout.id,
                    quantity: params[:quantities][index].to_i,
                )
            end

            render json: transaction, status: 200
        else
            render json: {errors: transaction.errors}, status: 500
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

        render json: CurrentTransactionBlueprint.render(transaction), status: 200
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
    
    def history_list_of_checkouts
        transactions = CompletedTransaction.where(buyer: current_user)

        render json: CompletedTransactionBlueprint.render(transactions), status: 200
    end

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

        render json: checkout_product
    end

    private

    def transaction_params
       params.permit(:status, :time_remaining, :is_paid, :buyer_id, :rider_id, :buyer_location_id) 
    end

    def location_params
        params.permit(:longitude, :latitude, :name)
    end
    
end
