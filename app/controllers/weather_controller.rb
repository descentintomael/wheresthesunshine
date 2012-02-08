class WeatherController < ApplicationController
  respond_to :json
  
  def nearest_sunshine
    location_arr = params[:location].split(/\W+/)
    found_zipcode = Zipcode.where("zipcode IN (?) OR (city IN (?) AND state IN (?))", location_arr, location_arr, location_arr).first
    
    # parameterize the select clause with square brackets
    @found_zipcodes = Zipcode.select("`condition`, temperature, zipcode, city, state, ( 3959 * acos( cos( radians((#{found_zipcode[:zipcode_point].x})) ) * cos( radians( X(zipcodes.zipcode_point) ) ) * cos( radians( Y(zipcodes.zipcode_point) ) - radians((#{found_zipcode[:zipcode_point].y})) ) + sin( radians((#{found_zipcode[:zipcode_point].x})) ) * sin( radians( X(zipcodes.zipcode_point) ) ) ) ) AS distance").joins("INNER JOIN weather_conditions ON weather_conditions.zipcode_id = zipcodes.id AND (`condition` LIKE 'fair%' OR `condition` LIKE 'sunny%')").order('distance ASC').limit(5)
    respond_with(@found_zipcodes)
  end
end
