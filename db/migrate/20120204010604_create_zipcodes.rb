class CreateZipcodes < ActiveRecord::Migration
  def change
    create_table(:zipcodes, :options => 'ENGINE=MyISAM') do |t|
      t.string :zipcode
      t.float :lat
      t.float :lng
      t.string :city
      t.string :state
      
      t.timestamps
    end
  end
end
