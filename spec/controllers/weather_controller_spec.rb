require 'spec_helper'

describe WeatherController do

  describe "GET 'nearest_sunshine'" do
    it "returns http success" do
      get 'nearest_sunshine'
      response.should be_success
    end
  end

end
