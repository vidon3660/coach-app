require 'spec_helper'

describe ContactsController do

  let!(:friendship) { FactoryGirl.create :friendship }
  let(:friend)      { friendship.friend }
  let(:user)        { friendship.user }
  let!(:training)    { FactoryGirl.create :training, coach: user, user: friend }
  let!(:training2)    { FactoryGirl.create :training, coach: friend, user: user }

  before(:each) { sign_in(user) }

  describe "GET 'index'" do
    it "returns all user friends, coaches and trained users" do
      get 'index'
      response.should be_success
      response.should render_template ("contacts/index")
      assigns(:friends).should include(friend)
      assigns(:coaches).should include(friend)
      assigns(:trained_users).should include(friend)
    end
  end

end
