require 'spec_helper'

describe HomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
      response.should render_template ("layouts/home")
      response.should render_template ("home/index")
    end
  end

end
