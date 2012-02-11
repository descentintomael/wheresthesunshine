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
    Zipcode.create!(@attr)
  end
  
  after(:each) do
    Zipcode.delete_all
  end
  
  it { should have_many(:weather_conditions) }
  
  # Zipcode field validations
  it { should validate_presence_of(:zipcode) }
  it { should validate_numericality_of(:zipcode) }
  it { should ensure_length_of(:zipcode).is_equal_to(5) }
  it { should validate_uniqueness_of(:zipcode) }

  # State field validations
  it { should validate_presence_of(:state) }
  it { should_not allow_value("12").for(:state) }
  it { should ensure_length_of(:state).is_equal_to(2) }
  
  # Geolocation validations
  it { should validate_presence_of(:lat) }
  it { should validate_presence_of(:lng) }
  it "should have the same X value of the point as the latitude" do
    Zipcode.first.zipcode_point.x.should == Zipcode.first.lat
  end
  
  it "should have the same Y value of the point as the longitude" do
    Zipcode.first.zipcode_point.y.should == Zipcode.first.lng
  end
  
  # City field validations
  it { should validate_presence_of(:city) }
  it { should ensure_length_of(:city).is_at_most(60) }
end