require 'spec_helper'

describe TasksController do

  describe "GET 'update_conditions'" do
    it "returns http success" do
      get 'update_conditions'
      response.should be_success
    end
  end

end
