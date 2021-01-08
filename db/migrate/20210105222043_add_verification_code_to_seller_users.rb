class AddVerificationCodeToSellerUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :seller_users, :verification_code, :int
  end
end
