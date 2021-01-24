class V1::RiderUser::RidersController < ApplicationController
    before_action :authenticate_v1_rider_user_rider!

    def test
        render json: current_user
    end
    
end
