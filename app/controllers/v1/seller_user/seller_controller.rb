class V1::SellerUser::SellerController < ApplicationController
    before_action :authenticate_v1_seller_user_seller!

    def index
        render json: current_user
    end
    
end
