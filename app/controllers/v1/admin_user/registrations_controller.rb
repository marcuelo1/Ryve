class V1::AdminUser::RegistrationsController < DeviseTokenAuth::RegistrationsController
    before_action :authenticate_v1_admin_user_admin!
    
    def create
        # Create admin
        admin_user = Admin.new(sign_up_params)

        if admin_user.save 
            render json: admin_user, status: 200
        else
            render json: {errors: admin_user.errors}, status: 500
        end
    end

    private
    def sign_up_params
        params.permit(:email, :nickname, :image, :first_name, :last_name, :password)
    end
    
end