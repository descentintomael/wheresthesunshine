require 'spec_helper'

describe WeatherCondition do
  # condition:string temperature:integer wind_speed:integer zipcode:references
  # Load up a sample weather condition
  before(:each) do
    # Any valid zipcode will do
    zipcode = Zipcode.first
    @attr = { :zipcode => zipcode,
              :temperature => 86,
              :wind_speed => 5,
              :condition => 'Sunny'}
  end
  
  it "should create a new instance given valid attributes" do
    WeatherCondition.create!(@attr)
  end
  
  describe "condition validation" do
    it "should require a weather condition" do
      no_condition = WeatherCondition.create(@attr.merge(:condition => ''))
      no_condition.should_not be_valid
    end
  end
  
  describe "temperature validation" do
    it "should require a temperature" do
      no_temp = WeatherCondition.create(@attr.merge(:temperature => ''))
      no_temp.should_not be_valid
    end
    
    it "should require an integer for temperature" do
      float_temp = WeatherCondition.create(@attr.merge(:temperature => '10.1'))
      float_temp.should_not be_valid
    end
    
    it "should reject non-numeric values for temperature" do
      non_numeric_temp = WeatherCondition.create(@attr.merge(:temperature => 'aa'))
      non_numeric_temp.should_not be_valid
    end
    
    it "should require an integer less than 140 for temperature" do
      high_temp = WeatherCondition.create(@attr.merge(:temperature => '141'))
      high_temp.should_not be_valid
    end
  end
  
  describe "wind speed validation" do
    it "should require a positive wind speed" do
      negative_wind_speed = WeatherCondition.create(@attr.merge(:wind_speed => -1))
      negative_wind_speed.should_not be_valid
    end
    
    it "should require an integer for wind speed" do
      float_wind_speed = WeatherCondition.create(@attr.merge(:wind_speed => 10.1))
      float_wind_speed.should_not be_valid
    end
  end

  # Commenting out for now until I figure out how to validate the relationship
  # describe "zipcode validation" do
  #   it "should require a zipcode" do
  #     no_zip = WeatherCondition.create(@attr.merge(:zipcode => nil))
  #     no_zip.should_not be_valid
  #   end
  # end
  
end
