require 'spec_helper'

describe WeatherCondition do
  # condition:string temperature:integer wind_speed:integer zipcode:references
  # Load up a sample weather condition
  before(:each) do
    # Any valid zipcode will do
    zipcode = Zipcode.first
    @attr = { :zipcode=>zipcode,
              :temperature=>86,
              :wind_speed=>5,
              :condition=>'Sunny'}
  end
  
  it "should create a new instance given valid attributes" do 
    WeatherCondition.create!(@attr)
  end
  
  describe "condition validation" do
    
  end
  
  describe "temperature validation" do
    
  end
  
  describe "wind speed validation" do
    
  end
  
  describe "zipcode validation" do
    
  end
  
end
