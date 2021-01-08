class V1::SellerUser::VerificationController < ApplicationController

    def verify
        seller_user = Seller.find(params[:seller_user_id])
        if seller_user.verification_code == params[:verification_code].to_i
            seller_user.is_verified = true
            seller_user.save 

            render json: {status: "Verified!"}, status: 200
        else
            render json: {error: "Wrong Code"}, status: 422
        end
    end

end
