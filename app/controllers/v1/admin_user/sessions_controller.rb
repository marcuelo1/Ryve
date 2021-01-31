class V1::AdminUser::SessionsController < DeviseTokenAuth::SessionsController

    def create
        admin_user = Admin.find_by(email: params[:email])
            
        if admin_user == nil 
            return render json: {status: "You dont have an account"}, status: 422 
        else
            super
        end
    end
    
end