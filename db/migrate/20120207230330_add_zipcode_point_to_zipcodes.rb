class AddZipcodePointToZipcodes < ActiveRecord::Migration
  def change
    add_column :zipcodes, :zipcode_point, :point, :null => false
    add_index :zipcodes, :zipcode_point, :spatial => true
  end
end
