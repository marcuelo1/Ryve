class ChangeVerificationCodeTypeOfSeller < ActiveRecord::Migration[6.0]
  def change
    change_column :sellers, :verification_code, :string
  end
end
