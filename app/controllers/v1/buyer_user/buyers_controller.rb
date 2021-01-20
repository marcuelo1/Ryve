class V1::BuyerUser::BuyersController < ApplicationController
    before_action :authenticate_v1_buyer_user_buyer!

    def locations
        render json: current_user
    end

    def products
        seller = Seller.find(params[:seller_id])

        products = []

        seller.product_categories.each do |category|
            products.push(category.name, category.products )
        end

        render json: products
    end
    
end
