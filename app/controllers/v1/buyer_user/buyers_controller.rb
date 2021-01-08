class V1::BuyerUser::BuyersController < ApplicationController
    before_action :authenticate_v1_buyer_user_buyer_user!

    def locations
        render json: current_user
    end
    
end
