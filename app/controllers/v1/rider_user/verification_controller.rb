class V1::RiderUser::VerificationController < ApplicationController

    def verify
        buyer_user = Rider.find(params[:rider_user_id])
        if buyer_user.verification_code == params[:verification_code]
            buyer_user.is_verified = true
            buyer_user.save 

            render json: {status: "Verified!"}, status: 200
        else
            render json: {error: "Wrong Code"}, status: 422
        end
    end

    def resend_verification
        seller_user = Seller.find(params[:rider_id])
        VerificationMailer.send_code(seller_user).deliver_later

        render json: {}, status: 200
    end

end
