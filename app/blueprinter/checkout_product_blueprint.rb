class CheckoutProductBlueprint < Blueprinter::Base
    fields :id

    field :name do |checkout_product|
        checkout_product.product.name
    end
end