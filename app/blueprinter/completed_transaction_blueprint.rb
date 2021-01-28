class CompletedTransactionBlueprint < Blueprinter::Base
    fields :id, :date

    association :buyer, blueprint: BuyerBlueprint do |completed_transaction|
        completed_transaction.buyer
    end

    association :buyer_location, blueprint: BuyerLocationBlueprint do |completed_transaction|
        completed_transaction.buyer_location
    end

    association :seller, blueprint: SellerBlueprint do |completed_transaction|
        completed_transaction.seller
    end

    association :products, blueprint: CheckoutProductBlueprint do |completed_transaction|
        CheckoutOrder.find(completed_transaction.checkout_order_id).checkout_products
    end
end