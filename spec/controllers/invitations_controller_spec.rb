require 'spec_helper'

describe InvitationsController do

  let(:user) { FactoryGirl.create :user }
  let(:other_user) { FactoryGirl.create :user }
  let(:banned_user) { FactoryGirl.create :user, status: "banned" }
  let(:new_user) { FactoryGirl.create :user, status: "new" }

  before(:each) { sign_in(user) }

  describe "GET 'index'" do
    it "returns http success" do
      pending "show invitations"
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      pending "show invitation with message"
      get 'show'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "should send only one invitation to contacts for other user" do
      -> { post :create, person_id: other_user }.should change(Invitation, :count).by(1)
      response.should be_redirect
      -> { post :create, person_id: user }.should raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
