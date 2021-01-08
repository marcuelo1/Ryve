class V1::BuyerUser::RegistrationsController < DeviseTokenAuth::RegistrationsController

    def create
        # Create user
        buyer_user = BuyerUser.new(sign_up_params)
        buyer_user.is_verified = false
        buyer_user.verification_code = (rand() * 10000).to_i

        if buyer_user.save 
            # Send Verification Code To User
            VerificationMailer.send_code(buyer_user).deliver_later
            render json: buyer_user, status: 200
        else
            render json: {errors: buyer_user.errors}, status: 500
        end
    end

    private
    def sign_up_params
        params.permit(:email, :nickname, :image, :first_name, :last_name, :phone_number, :password)
    end

end
