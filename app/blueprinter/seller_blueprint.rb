class SellerBlueprint < Blueprinter::Base
    fields :id, :company_name, :email
    
    field :profile_image do |seller, options|
        options[:profile_image]
    end

    field :background_image do |seller, options|
        options[:background_image]
    end
end