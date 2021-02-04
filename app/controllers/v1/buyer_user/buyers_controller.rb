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

    def show_sizes_and_additionals
        product = Product.find(params[:product_id])

        sizes = product.sizes 
        additionals = product.additionals 

        render json: {sizes: sizes, additionals: additionals}, status: 200
    end

    def add_to_cart
        product = Product.find(params[:product_id])
        seller = product.product_category.seller
        cart = Cart.where(buyer: current_user, seller: seller).first_or_create

        if cart.checkout_order_id == nil 
            checkout_order = CheckoutOrder.create()
            cart.checkout_order_id = checkout_order.id 
            cart.save 

            # Amount of Checkout Order
            total_amount = checkout_order.amount

            checkout_product = checkout_order.checkout_products.create(product_id: params[:product_id], quantity: params[:quantity])
            checkout_size = CheckoutSize.create(size_id: params[:size_id], checkout_product: checkout_product)
            total_amount += checkout_size.size.price

            params[:additionals].each do |additional|
                checkout_additional = checkout_additional = checkout_product.checkout_additionals.create(additional_id: additional)
                total_amount += checkout_additional.additional.price
            end

            checkout_order.update(amount: total_amount)
        else
            checkout_order = CheckoutOrder.find(cart.checkout_order_id)
            total_amount = checkout_order.amount

            checkout_product = checkout_order.checkout_products.where(product_id: params[:product_id]).first 

            if checkout_product 
                if checkout_product.checkout_size.size_id == params[:size_id].to_i
                    check = checkout_product.checkout_additionals.map{|additional| params[:additionals].include?("#{additional.additional_id}")}.uniq
                    case check.count
                    when 1
                        if check.first == true # It has existing product in cart with the same size and additionals
                            product_current_quantity = checkout_product.quantity
                            checkout_product.update(quantity: product_current_quantity + params[:quantity].to_i)

                            # Add the amount of the order to the total amount
                            checkout_size = checkout_product.checkout_size
                            total_amount += checkout_size.size.price 

                            checkout_product.checkout_additionals.each do |checkout_additional|
                                total_amount += checkout_additional.additional.price
                            end
                        else    # Product with same size and additionals does not exist
                            checkout_product = checkout_order.checkout_products.create(product_id: params[:product_id], quantity: params[:quantity])
                            checkout_size = CheckoutSize.create(size_id: params[:size_id], checkout_product: checkout_product)
                            total_amount += checkout_size.size.price
                
                            params[:additionals].each do |additional|
                                checkout_additional = checkout_product.checkout_additionals.create(additional_id: additional)
                                total_amount += checkout_additional.additional.price
                            end
                        end
                    when 2  # Product with same size and additionals does not exist
                        checkout_product = checkout_order.checkout_products.create(product_id: params[:product_id], quantity: params[:quantity])
                        checkout_size = CheckoutSize.create(size_id: params[:size_id], checkout_product: checkout_product)
                        total_amount += checkout_size.size.price
            
                        params[:additionals].each do |additional|
                            checkout_additional = checkout_product.checkout_additionals.create(additional_id: additional)
                            total_amount += checkout_additional.additional.price
                        end
                    end
                else # Product with same size does not exist
                    checkout_product = checkout_order.checkout_products.create(product_id: params[:product_id], quantity: params[:quantity])
                    checkout_size = CheckoutSize.create(size_id: params[:size_id], checkout_product: checkout_product)
                    total_amount += checkout_size.size.price
        
                    params[:additionals].each do |additional|
                        checkout_additional = checkout_product.checkout_additionals.create(additional_id: additional)
                        total_amount += checkout_additional.additional.price
                    end
                end
            else # Product does not exist in cart
                checkout_product = checkout_order.checkout_products.create(product_id: params[:product_id], quantity: params[:quantity])
                checkout_size = CheckoutSize.create(size_id: params[:size_id], checkout_product: checkout_product)
                total_amount += checkout_size.size.price

                params[:additionals].each do |additional|
                    checkout_additional = checkout_product.checkout_additionals.create(additional_id: additional)
                    total_amount += checkout_additional.additional.price
                end
            end

            checkout_order.update(amount: total_amount)
        end

        render json: CartBlueprint.render(cart)
    end

    def list_of_carts
        carts = Cart.where(buyer: current_user).map{|cart| 
            {
                seller: cart.seller.company_name, 
                amount: CheckoutOrder.find(cart.checkout_order_id).amount, 
                id: cart.id
            }
        }
        render json: carts
    end

    def show_cart
        cart = Cart.find(params[:cart_id])
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

    ####    UTILITIES
    def checkout_utility_transaction
        transaction = UtilityPending.new(utility_transaction_params)
        transaction.buyer = current_user
        
        if transaction.save 
            render json: transaction, status: 200
        else
            render json: {errors: transaction.errors}, status: 500
        end
    end

    def show_utility_current
        utility = UtilityCurrent.find(params[:utility_current_id])
        render json: utility, status: 200
    end 

    def list_of_completed_utilities
        utilities = current_user.utility_completeds

        render json: utilities, status: 200
    end

    private

    def location_params
        params.permit(:longitude, :latitude, :name)
    end

    def utility_transaction_params
        params.permit(:provider_id, :provider_type, :bill_number, :type_of_transaction, :is_paid, :amount)
    end
end