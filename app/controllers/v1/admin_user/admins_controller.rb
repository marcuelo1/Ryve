class V1::AdminUser::AdminsController < ApplicationController
    before_action :authenticate_v1_admin_user_admin!

    def list_of_electricity_utility_current_transaction
        utilities = UtilityCurrent.where(provider_type: "ElectiricityProvider")

        render json: utilities, status: 200
    end

    def list_of_water_utility_current_transaction
        utilities = UtilityCurrent.where(provider_type: "WaterProvider")

        render json: utilities, status: 200
    end

    def list_of_internet_utility_current_transaction
        utilities = UtilityCurrent.where(provider_type: "InternetProvider")

        render json: utilities, status: 200
    end

    def change_utility_current_status
        utility = UtilityCurrent.find(params[:utility_current_id])

        if utility.update(status: params[:status])
            render json: utility, status: 200
        else
            render json: {errors: utility.errors}, status: 500
        end
    end
    
    def compelete_utility_current
        utility = UtilityCurrent.find(params[:utility_current_id])
        completed_utility = UtilityCompleted.new()
        completed_utility.buyer = utility.buyer
        completed_utility.rider = utility.rider
        completed_utility.buyer = utility.buyer
        completed_utility.bill_number = utility.bill_number
        completed_utility.provider = utility.provider
        completed_utility.date_transacted = utility.created_at
        completed_utility.type_of_transaction = utility.type_of_transaction
        completed_utility.date_paid = Time.now
        completed_utility.amount = utility.amount

        if completed_utility.save 
            utility.destroy 
            render json: completed_utility, status: 200
        else 
            render json: {errors: completed_utility.errors}, status: 500
        end
    end
    
    
end
