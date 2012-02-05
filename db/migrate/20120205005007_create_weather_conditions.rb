class CreateWeatherConditions < ActiveRecord::Migration
  def change
    create_table :weather_conditions do |t|
      t.string :condition
      t.integer :temperature
      t.integer :wind_speed
      t.references :zipcode

      t.timestamps
    end
    add_index :weather_conditions, :zipcode_id
  end
end
