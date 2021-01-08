class V1::RiderUser::RegistrationsController < DeviseTokenAuth::RegistrationsController

    def create
        # Create user
        rider_user = Rider.new(sign_up_params)
        rider_user.is_verified = false
        rider_user.verification_code = (rand() * 10000).to_i

        if rider_user.save 
            # Send Verification Code To User
            VerificationMailer.send_code(rider_user).deliver_later
            render json: rider_user, status: 200
        else
            render json: {errors: rider_user.errors}, status: 500
        end
    end

    private
    def sign_up_params
        params.permit(:email, :nickname, :image, :first_name, :last_name, :phone_number, :address, :plate_number, :password)
    end

end
