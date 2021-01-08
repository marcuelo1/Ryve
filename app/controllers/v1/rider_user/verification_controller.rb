class V1::RiderUser::VerificationController < ApplicationController

    def verify
        buyer_user = Rider.find(params[:rider_user_id])
        if buyer_user.verification_code == params[:verification_code].to_i
            buyer_user.is_verified = true
            buyer_user.save 

            render json: {status: "Verified!"}, status: 200
        else
            render json: {error: "Wrong Code"}, status: 422
        end
    end

end
