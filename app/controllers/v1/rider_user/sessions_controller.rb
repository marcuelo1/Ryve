class V1::RiderUser::SessionsController < DeviseTokenAuth::SessionsController

    def create
        if params[:facebook_id]

        elsif params[:google_id]

        else
            seller_user = Rider.find_by(email: params[:email])
            
            if seller_user == nil 
                return render json: {status: "You dont have an account"}, status: 422 
            end

            super 
            
            # if seller_user.is_verified?
            #     super
            # else
            #     render json: {status: "Need to verify account"}, status: 401
            # end
        end
    end

end
