class ProductBlueprint < Blueprinter::Base
    fields :id, :is_available

    association :product_category, blueprint: ProductCategoryBlueprint do |product|
        product.product_category
    end
    
    field :product_image do |seller, options|
        options[:product_image]
    end
end