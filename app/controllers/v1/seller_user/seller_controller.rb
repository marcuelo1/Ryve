class V1::SellerUser::SellerController < ApplicationController
    before_action :authenticate_v1_seller_user_seller!

    def index
        render json: current_user
    end

    def create_product
        category = ProductCategory.new(name: params[:category], seller: current_user)

        if category.save 
            # Sample data format to be send
            # products: [
            #     {
            #         name: "sample",
            #         price: 23
            #         discount: 10
            #     },
            #     {
            #         name: "sample",
            #         price: 23
            #         discount: 10
            #     }
            # ]
            params[:products].each do |product|
                temp_product = Product.new(name: product[:name], price: product[:price], discount: product[:discount], product_category: category)
                
                if !temp_product.save 
                    render json: {errors: temp_product.errors}, status: 500
                    category.destroy 
                end
            end

            render json: {}, status: 200
        else
            render json: {errors: category.errors}, status: 500
        end
    end
    
end
