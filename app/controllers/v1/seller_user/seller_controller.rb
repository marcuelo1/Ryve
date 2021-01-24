class V1::SellerUser::SellerController < ApplicationController
    before_action :authenticate_v1_seller_user_seller!

    def create_product
        category = ProductCategory.find_or_create_by(name: params[:category], seller: current_user)

        
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
    end

    def edit_schedule
        current_user.schedule.update(schedule_params)
        render json: {success: true}, status: 200
    end

    def list_of_products
        categories = current_user.product_categories

        products = categories.collect do |category|
            {category: category.name, products: category.products}
        end

        render json: products, status: 200
    end

    def show_product
        product = Product.find(params[:product_id])

        render json: product, status: 200
    end

    def edit_location
        if current_user.update(longitude: params[:longitude], latitude: params[:latitude], location: params[:location])
            render json: {}, status: 200
        else
            render json: {}, status: 500
        end
    end
    
    private
    def schedule_params
        params.permit(:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday)
    end
    
end
