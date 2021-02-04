class CreateElectricityProviders < ActiveRecord::Migration[6.0]
  def change
    create_table :electricity_providers do |t|
      t.string :name

      t.timestamps
    end
  end
end
