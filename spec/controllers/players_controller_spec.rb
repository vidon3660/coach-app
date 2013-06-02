require 'spec_helper'

describe PlayersController do

  let(:user) { FactoryGirl.create :user }

  describe "GET 'show'" do
    it "should return active user public profile" do
      get :show, id: user.id
      assigns(:user).should == user
      response.should be_success
      response.should render_template ("players/show")
    end
  end

end
