require 'net/http'
class TasksController < ApplicationController
  def update_conditions
    batch_size = 200
    insert_arr = []
    current_timestamp = Time.now.utc.strftime("%FT%T")
    Zipcode.find_in_batches(:batch_size => batch_size) do |zipcodes|
      threads = []
      zipcodes.each do |zipcode|
        threads << Thread.new(zipcode) do |zipcode|
          if zipcode[:weather_station].nil?
            puts "Zipcode #{zipcode[:zipcode]} has no weather station"
          else
            insert_string = ""
            loop_count = 0
            while insert_string.empty? && loop_count < 10
              loop_count += 1
              begin
                xml = Nokogiri::XML(Net::HTTP.get(URI.parse("http://www.weather.gov/xml/current_obs/#{zipcode[:weather_station]}.xml")))
                # condition:string temperature:integer wind_speed:integer zipcode:references
                condition = nil
                condition = xml.xpath('/current_observation/weather').first.content unless xml.xpath('/current_observation/weather').empty?
                temperature = 0
                temperature = xml.xpath('/current_observation/temp_f').first.content.to_i unless xml.xpath('/current_observation/temp_f').empty?
                wind_speed = 0
                wind_speed = xml.xpath('/current_observation/wind_mph').first.content.to_i unless xml.xpath('/current_observation/wind_mph').empty?
                # None of these are escaped, but I'll do that later
                insert_string = "(#{zipcode[:id]},'#{condition}',#{temperature},#{wind_speed},'#{current_timestamp}','#{current_timestamp}')"
              rescue Timeout::Error
                puts "Zipcode #{zipcode[:zipcode]} timed out"
              end
            end
            Thread.current[:my_val] = insert_string
          end
        end
      end
      threads.each do |t|
        t.join
        insert_arr << t[:my_val]
      end

      if insert_arr.length >= 4000
        WeatherCondition.connection.execute("INSERT INTO `weather_conditions` (`zipcode_id`,`condition`,`temperature`,`wind_speed`,`created_at`,`updated_at`) VALUES #{insert_arr.join(',')}")
        insert_arr = []
      end
    end

    unless insert_arr.empty?
      WeatherCondition.connection.execute("INSERT INTO `weather_conditions` (`zipcode_id`,`condition`,`temperature`,`wind_speed`,`created_at`,`updated_at`) VALUES #{insert_arr.join(',')}")
      insert_arr = []
    end
    
    WeatherCondition.delete_all(["created_at < ?",current_timestamp])
  end
end
