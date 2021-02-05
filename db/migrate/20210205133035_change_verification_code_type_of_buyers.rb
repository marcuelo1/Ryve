class ChangeVerificationCodeTypeOfBuyers < ActiveRecord::Migration[6.0]
  def change
    change_column :buyers, :verification_code, :string
  end
end
