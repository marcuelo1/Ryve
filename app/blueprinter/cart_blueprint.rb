class CartBlueprint < Blueprinter::Base
    fields :id, :checkout_order_id

    association :buyer, blueprint: BuyerBlueprint do |cart|
        cart.buyer
    end

    association :seller, blueprint: SellerBlueprint do |cart|
        cart.seller
    end

    association :products, blueprint: CheckoutProductBlueprint do |cart|
        CheckoutOrder.find(cart.checkout_order_id).checkout_products
    end

    field :amount do |cart|
        CheckoutOrder.find(cart.checkout_order_id).amount 
    end
end