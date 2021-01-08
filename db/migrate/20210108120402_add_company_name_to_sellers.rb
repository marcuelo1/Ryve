class AddCompanyNameToSellers < ActiveRecord::Migration[6.0]
  def change
    add_column :sellers, :company_name, :string
  end
end
