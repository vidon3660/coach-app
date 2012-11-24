require 'spec_helper'

describe WelcomeController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
      response.should render_template ("layouts/user")
      response.should render_template ("user/index")
    end
  end

end
