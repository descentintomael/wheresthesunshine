# require 'GeoRuby'
class Zipcode < ActiveRecord::Base
  attr_accessible :zipcode,:lat,:lng,:city,:state,:population,:weather_station,:zipcode_point
  has_many :weather_conditions, :dependent => :destroy
  
  validates :zipcode, :presence => true,
                      :length => { :is => 5},
                      :numericality => true,
                      :uniqueness =>true
  validates :state, :presence => true,
                    :length => { :is => 2 },
                    :format => { :with => /[a-z]{2}/i }
  validates :lat, :presence => true,
                  :numericality => true
  validates :lng, :presence => true,
                  :numericality => true
  validates :city,  :presence => true,
                    :length => { :maximum => 60}
  after_initialize :create_zipcode_point
  
  # private             
  def create_zipcode_point
    self.zipcode_point = Point.from_x_y(lat, lng)
  end
end
