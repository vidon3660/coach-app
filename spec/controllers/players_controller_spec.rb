require 'spec_helper'

describe PlayersController do

  let(:user) { FactoryGirl.create :user }

  before(:each) { sign_in(user) }

  describe "GET 'show'" do
    it "should return active user public profile" do
      get :show, id: user.player.id
      assigns(:player).should == user.player
      response.should be_success
      response.should render_template ("layouts/user")
      response.should render_template ("players/show")
    end
  end

end
