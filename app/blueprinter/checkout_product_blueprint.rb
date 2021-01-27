class CheckoutProductBlueprint < Blueprinter::Base
    fields :id, :quantity

    field :name do |checkout_product|
        checkout_product.product.name
    end

    field :price do |checkout_product|
        checkout_product.product.price
    end

    field :discount do |checkout_product|
        checkout_product.product.discount
    end
end