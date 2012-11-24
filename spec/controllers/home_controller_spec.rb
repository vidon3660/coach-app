require "spec_helper"

describe HomeController do
  let(:user) { FactoryGirl.create :user } 
  before(:each) { sign_in(user) }

  describe "signed user" do
    it "GET 'index'" do
      get :index
      response.should render_template ("layouts/user")
      response.should render_template ("home/index")
    end
  end

end
