require "spec_helper"

describe HomeController do
  let(:user) { FactoryGirl.create :user } 

  describe "unsigned user" do
    it "render unsigned view" do
      get :index
      response.should render_template ("layouts/welcome")      
      response.should render_template ("home/unsigned")
    end
  end

  describe "unsigned user" do
    before(:each) { sign_in(user) }
    
    it "render unsigned view" do
      get :index
      response.should render_template ("layouts/application")      
      response.should render_template ("home/index")
    end
  end

end
