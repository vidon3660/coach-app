require 'spec_helper'

describe BannedController do
  let(:user) { FactoryGirl.create :user, status: "banned" }
  before(:each) { sign_in(user) }

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      response.should be_success
      response.should render_template ("layouts/banned")
      response.should render_template ("banned/index")
    end
  end

end
