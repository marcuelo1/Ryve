class V1::SellerUser::SellerController < ApplicationController
    before_action :authenticate_v1_seller_user_seller!

    def create_product
        category = ProductCategory.find_or_create_by(name: params[:category], seller: current_user)

        params[:products].each do |product|
            temp_product = Product.new(name: product[:name], product_category: category, product_image: product[:product_image])

            if !temp_product.save 
                category.destroy 
                return render json: {errors: temp_product.errors}, status: 500
            end

            # Sizes 
            product[:sizes].each do |size|
                temp_size = Size.new(name: size[:name], price: size[:price], discount: size[:discount])
                temp_size.product = temp_product

                if !temp_size.save 
                    temp_product.destroy
                    return render json: {errors: temp_size.errors}, status: 500
                end
            end
            
            # Additionals 
            product[:additionals].each do |additional|
                temp_additional = Additional.new(name: additional[:name], price: additional[:price], discount: additional[:discount])
                temp_additional.product = temp_product

                if !temp_additional.save 
                    temp_product.destroy
                    return render json: {errors: temp_additional.errors}, status: 500
                end
            end
        end

        render json: {}, status: 200
    end

    def edit_product_image
        product = Product.find(params[:product_id])

        product.update(product_image: params[:product_image])

        render json: ProductBlueprint.render(product, product_image: product.product_image.attached? ? url_for(product.product_image) : nil), status: 200
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

    def list_of_current_transactions
        transactions = CurrentTransaction.where(seller: current_user)

        render json: CurrentTransactionBlueprint.render(transactions), status: 200
    end

    def list_of_completed_transactions
        transactions = CompletedTransaction.where(seller: current_user)

        render json: CompletedTransactionBlueprint.render(transactions), status: 200
    end
    
    def post_profile_image
        current_user.update(profile_image: params[:profile_image])

        render json: SellerBlueprint.render(current_user, 
            profile_image: current_user.profile_image.attached? ? url_for(current_user.profile_image) : nil, 
            background_image: current_user.background_image.attached? ? url_for(current_user.background_image) : nil
            ), status: 200
    end
    
    def edit_profile_image
        current_user.update(profile_image: params[:profile_image])

        render json: SellerBlueprint.render(current_user, 
            profile_image: current_user.profile_image.attached? ? url_for(current_user.profile_image) : nil, 
            background_image: current_user.background_image.attached? ? url_for(current_user.background_image) : nil
            ), status: 200
    end
    
    def post_background_image
        current_user.update(background_image: params[:background_image])

        render json: SellerBlueprint.render(current_user, 
            profile_image: current_user.profile_image.attached? ? url_for(current_user.profile_image) : nil, 
            background_image: current_user.background_image.attached? ? url_for(current_user.background_image) : nil
            ), status: 200
    end
    
    def edit_background_image
        current_user.update(background_image: params[:background_image])

        render json: SellerBlueprint.render(current_user, 
            profile_image: current_user.profile_image.attached? ? url_for(current_user.profile_image) : nil, 
            background_image: current_user.background_image.attached? ? url_for(current_user.background_image) : nil
            ), status: 200
    end

    def edit_product_availability
        product = Product.find(params[:product_id])

        product.update(is_available: params[:is_available])

        render json: ProductBlueprint.render(product, product_image: product.product_image.attached? ? url_for(product.product_image) : nil), status: 200
    end
    
    
    private
    def schedule_params
        params.permit(:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday)
    end
    
end
