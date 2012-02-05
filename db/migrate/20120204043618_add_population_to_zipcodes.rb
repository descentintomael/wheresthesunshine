class AddPopulationToZipcodes < ActiveRecord::Migration
  def change
    add_column :zipcodes, :population, :integer

  end
end
