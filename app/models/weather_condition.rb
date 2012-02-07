class WeatherCondition < ActiveRecord::Base
  belongs_to :zipcode
  
  validates :condition,   :presence => true
  validates :temperature, :presence => true,
                          :numericality => {  :only_integer => true, 
                                              :less_than => 140 }
  validates :wind_speed,  :presence => true,
                          :numericality => {  :only_integer => true, 
                                              :less_than => 250, 
                                              :greater_than_or_equal_to => 0 }

end
