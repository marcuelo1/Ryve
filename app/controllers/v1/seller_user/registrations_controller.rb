class V1::SellerUser::RegistrationsController < DeviseTokenAuth::RegistrationsController
    
    def create
        # Create user
        seller_user = Seller.new(sign_up_params)
        seller_user.is_verified = false
        seller_user.verification_code = 4.times.map{rand(10)}.join

        if seller_user.save 
            # Send Verification Code To User
            VerificationMailer.send_code(seller_user).deliver_later

            # Schedule create
            schedule = Schedule.new()
            schedule.seller = seller_user
            schedule.save

            render json: seller_user, status: 200
        else
            render json: {errors: seller_user.errors}, status: 500
        end
    end

    private
    def sign_up_params
        params.permit(:email, :nickname, :image, :company_name, :phone_number, :longitude, :latitude, :password)
    end
    
end