class ApplicationController < ActionController::Base
    include DeviseTokenAuth::Concerns::SetUserByToken
    skip_before_action :verify_authenticity_token
    
    def current_user
        current_v1_seller_user_seller || current_v1_buyer_user_buyer || current_v1_rider_user_rider
    end
    
    rescue_from ActiveRecord::RecordNotFound, :with => :id_not_found

    def id_not_found(e)
        render json: {error: e}, status: 200
    end
    
    
end
