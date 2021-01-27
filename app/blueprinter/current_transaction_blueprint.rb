class CurrentTransactionBlueprint < Blueprinter::Base
    fields :id, :status, :time_remaining, :is_paid

    association :buyer, blueprint: BuyerBlueprint do |current_transaction|
        current_transaction.buyer
    end

    association :buyer_location, blueprint: BuyerLocationBlueprint do |current_transaction|
        current_transaction.buyer_location
    end

    association :products, blueprint: CheckoutProductBlueprint do |current_transaction|
        CheckoutOrder.find(current_transaction.checkout_order_id).checkout_products
    end
end