puts "Loading up zipcode database"
# Delete all the current zipcode records
Zipcode.delete_all
File.open("db/seeds/zipcode_seeds.csv", "r") do |zipcodes| 
  zipcodes.read.each_line do |zipcode_line|
    puts "Working with line: #{zipcode_line.chomp.split(',')}"
    zipcode,population,city,state,lat,lng,weather_station = zipcode_line.chomp.split(',')
    Zipcode.create!(:zipcode => zipcode,
                    :lat => lat,
                    :lng => lng,
                    :city => city,
                    :state => state,
                    :population => population,
                    :weather_station => weather_station)
  end
end
puts "Finished loading zipcode database"
puts "Be sure to load up the current weather conditions"

