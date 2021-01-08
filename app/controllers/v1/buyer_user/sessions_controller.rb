class V1::BuyerUser::SessionsController < DeviseTokenAuth::SessionsController

    def create
        if params[:facebook_id]

        elsif params[:google_id]

        else
            buyer_user = Buyer.find_by(email: params[:email])

            if buyer_user.is_verified?
                super
            else
                render json: {status: "Need to verify account"}, status: 401
            end
        end
    end

end
