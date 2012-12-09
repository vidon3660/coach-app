require 'spec_helper'

describe PeopleController do

  let(:user) { FactoryGirl.create :user }
  let(:banned_user) { FactoryGirl.create :user, status: "banned" }
  let(:new_user) { FactoryGirl.create :user, status: "new" }

  before(:each) { sign_in(user) }

  describe "GET 'show'" do
    it "should return active user public profile" do
      get :show, id: user.id
      assigns(:user).should == user
      response.should be_success
      response.should render_template ("layouts/user")
      response.should render_template ("people/show")
    end

    it "should redirect and alert if new user public profile" do
      get :show, id: new_user.id
      response.should be_redirect
    end

    it "should redirect and alert if banned user public profile" do
      get :show, id: banned_user.id
      response.should be_redirect
    end
  end

end
