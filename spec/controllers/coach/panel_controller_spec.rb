require 'spec_helper'

describe Coach::PanelController do
  let(:coach) { FactoryGirl.create :coach } 
  before(:each) { sign_in(coach) }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
      response.should render_template("layouts/user")
      response.should render_template("coach/panel/index")      
    end
  end
end
