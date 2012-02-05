class AddWeatherStationToZipcodes < ActiveRecord::Migration
  def change
    add_column :zipcodes, :weather_station, :string

  end
end
