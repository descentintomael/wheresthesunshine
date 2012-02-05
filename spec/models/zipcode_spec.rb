require 'spec_helper'

describe Zipcode do
  # Load up a sample zipcode (one which should not exist)
  before(:each) do
    @attr = { :zipcode=>'55555',
              :lat=>38.72,
              :lng=>-90.46,
              :city=>'Nowhere',
              :state=>'CA',
              :population=>90000}
  end
  
  it "should create a new instance given valid attributes" do 
    Zipcode.create!(@attr)
  end
  
  describe "zipcode validations" do
    it "should require a zipcode" do
      missing_zipcode = Zipcode.new(@attr.merge(:zipcode=>""))
      missing_zipcode.should_not be_valid
    end
    
    # Note, these two tests may disappear later on if/when Canada is included
    it "should only accept digits in the zipcode" do
      invalid_zipcode = Zipcode.new(@attr.merge(:zipcode=>"nozip"))
      invalid_zipcode.should_not be_valid
    end
    
    it "shouldn't allow more than 5 digits" do
      long_zipcode = Zipcode.new(@attr.merge(:zipcode=>"12345678"))
      long_zipcode.should_not be_valid
    end
    
    it "shouldn't allow less than 5 digits" do
      short_zipcode = Zipcode.new(@attr.merge(:zipcode=>"1234"))
      short_zipcode.should_not be_valid
    end
  end
  
  describe "state validations" do
    it "should require a state" do
      missing_state = Zipcode.new(@attr.merge(:state=>""))
      missing_state.should_not be_valid
    end
    
    it "should only accept letters" do
      invalid_state = Zipcode.new(@attr.merge(:state=>"12"))
      invalid_state.should_not be_valid
    end
    
    it "shouldn't allow more than two characters" do
      long_state = Zipcode.new(@attr.merge(:state=>"california"))
      long_state.should_not be_valid
    end
    
    it "shouldn't allow less than two characters" do
      short_state = Zipcode.new(@attr.merge(:state=>"c"))
      short_state.should_not be_valid
    end
  end
  
  describe "geolocation validations" do
    it "should require a latitude" do
      missing_lat = Zipcode.new(@attr.merge(:lat=>nil))
      missing_lat.should_not be_valid
    end
    
    it "should require a longitude" do
      missing_lng = Zipcode.new(@attr.merge(:lng=>nil))
      missing_lng.should_not be_valid
    end
  end
  
  describe "city validations" do
    it "should require a city" do
      missing_city = Zipcode.new(@attr.merge(:city=>""))
      missing_city.should_not be_valid
    end
    
    it "shouldn't allow long city names" do
      long_city = "a"*100
      long_city_zipcode = Zipcode.new(@attr.merge(:city=>long_city))
      long_city_zipcode.should_not be_valid
    end
  end
end