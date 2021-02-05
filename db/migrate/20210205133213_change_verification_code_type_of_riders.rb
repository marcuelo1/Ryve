class ChangeVerificationCodeTypeOfRiders < ActiveRecord::Migration[6.0]
  def change
    change_column :riders, :verification_code, :string
  end
end
