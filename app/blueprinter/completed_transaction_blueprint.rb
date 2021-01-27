class CompletedTransactionBlueprint < Blueprinter::Base
    fields :id, :date

    association :buyer, blueprint: BuyerBlueprint do |current_transaction|
        current_transaction.buyer
    end

    association :buyer_location, blueprint: BuyerLocationBlueprint do |current_transaction|
        current_transaction.buyer_location
    end

    association :seller, blueprint: SellerBlueprint do |current_transaction|
        current_transaction.seller
    end

    association :products, blueprint: CheckoutProductBlueprint do |current_transaction|
        CheckoutOrder.find(current_transaction.checkout_order_id).checkout_products
    end
end