require 'spec_helper'

describe Admin::PanelController do
  let(:admin) { FactoryGirl.create :admin } 
  before(:each) { sign_in(admin) }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
      response.should render_template("layouts/application")
      response.should render_template("admin/panel/index")      
    end
  end

end
