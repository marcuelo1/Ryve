class CreateWaterProvides < ActiveRecord::Migration[6.0]
  def change
    create_table :water_provides do |t|
      t.string :name

      t.timestamps
    end
  end
end
