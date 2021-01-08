class ApplicationController < ActionController::Base
    include DeviseTokenAuth::Concerns::SetUserByToken
    skip_before_action :verify_authenticity_token
    
    def current_user
        current_v1_seller_user_seller_user || current_v1_buyer_user_buyer_user
    end
    
end
