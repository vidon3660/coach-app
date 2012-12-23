require 'spec_helper'

describe ContactsController do

  let!(:user)       { FactoryGirl.create :user }
  let!(:other_user) { FactoryGirl.create :user }
  let!(:relationship) { FactoryGirl.create(:relationship, user: user, contact: other_user) }

  before(:each) { sign_in(user) }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
      response.should render_template ("layouts/user")
      response.should render_template ("contacts/index")
      assigns(:contacts).should include(other_user)
    end
  end

end
