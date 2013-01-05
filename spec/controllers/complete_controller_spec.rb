require 'spec_helper'

describe CompleteController do
  let(:user)   { FactoryGirl.create :user, status: "new" }
  let(:player) { user.player }
  
  before(:each) { sign_in(user) }
  
  describe "GET 'edit'" do
    it "should return form to update current user" do
      get 'edit'
      response.should be_success
      response.should render_template ("layouts/user")
      response.should render_template ("complete/edit")
    end
  end

  describe "PUT 'update'" do
    it "should update user if valid" do
      put :update, player: { first_name: "Peter" }
      user.reload
      player.reload
      user.should be_active
      player.first_name.should == "Peter"
      response.should redirect_to(root_url)
    end

    it "should render 'edit' if user isn't valid" do
      put :update, player: { birth: (Date.today + 2.day) }
      user.should_not be_active
      response.should render_template ("complete/edit")
    end
  end

end
