require 'spec_helper'

describe ProfileController do
  let(:user) { FactoryGirl.create :user }
  let(:player) { user.player }

  before(:each) { sign_in(user) }

  describe "GET 'index'" do
    it "should return current player profile" do
      get 'index'
      response.should be_success
      response.should render_template ("layouts/user")
      response.should render_template ("profile/index")
    end
  end

  describe "GET 'informations'" do
    it "should return player informations form" do
      get 'informations'
      response.should be_success
      response.should render_template ("layouts/user")
      response.should render_template ("profile/informations")
    end
  end

  describe "PUT 'update'" do
    it "should update player informations" do
      put :update, player: { first_name: "Peter" }
      player.reload
      player.first_name.should == "Peter"
      response.should redirect_to(profile_informations_url)
    end

    it "should render 'informations' if player isn't valid" do
      put :update, player: { birth: (Date.today + 2.day) }
      response.should render_template ("profile/informations" )
    end
  end

end
