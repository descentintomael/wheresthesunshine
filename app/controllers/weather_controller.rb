require 'geokit'
class WeatherController < ApplicationController
  respond_to :json
  
  def nearest_sunshine
    # Use geokit to geocode the location parameter
    location_hash = Geokit::Geocoders::GeonamesGeocoder.geocode(params[:location]).hash
    
    @found_zipcodes = Zipcode.select("`condition`, temperature, zipcode, city, state, ( 3959 * acos( cos( radians((#{location_hash[:lat]})) ) * cos( radians( X(zipcodes.zipcode_point) ) ) * cos( radians( Y(zipcodes.zipcode_point) ) - radians((#{location_hash[:lng]})) ) + sin( radians((#{location_hash[:lat]})) ) * sin( radians( X(zipcodes.zipcode_point) ) ) ) ) AS distance").joins("INNER JOIN weather_conditions ON weather_conditions.zipcode_id = zipcodes.id AND (`condition` LIKE 'fair%' OR `condition` LIKE 'sunny%')").order('distance ASC').limit(5)
    respond_with(@found_zipcodes)
  end
end
