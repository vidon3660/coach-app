require 'spec_helper'

describe ProfileController do
  let(:user) { FactoryGirl.create :user }
  before(:each) { sign_in(user) }

  describe "GET 'index'" do
    it "should return current user profile" do
      get 'index'
      response.should be_success
      response.should render_template ("layouts/user")
      response.should render_template ("profile/index")
    end
  end

  describe "GET 'show'" do
    it "should return active user public profile" do
      get :show, id: user.id
      assigns(:user).should == user
      response.should be_success
      response.should render_template ("layouts/user")
      response.should render_template ("profile/show")
    end

    it "should redirect and alert if new user public profile" do
      user2 = FactoryGirl.create :user, status: "new"
      get :show, id: user2.id
      response.should be_redirect
    end

    it "should redirect and alert if banned user public profile" do
      user2 = FactoryGirl.create :user, status: "banned"
      get :show, id: user2.id
      response.should be_redirect
    end
  end

  describe "GET 'informations'" do
    it "should return user informations form" do
      get 'informations'
      response.should be_success
      response.should render_template ("layouts/user")
      response.should render_template ("profile/informations")
    end
  end

  describe "PUT 'update'" do
    it "should update user informations" do
      put :update, user: { first_name: "Peter" }
      user.reload
      user.first_name.should == "Peter"
      response.should redirect_to(profile_informations_url)
    end

    it "should render 'informations' if user isn't valid" do
      put :update, user: { birth: (Date.today + 2.day) }
      response.should render_template ("profile/informations" )
    end
  end

end
