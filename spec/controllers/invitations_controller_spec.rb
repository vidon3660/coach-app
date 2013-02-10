require 'spec_helper'

describe InvitationsController do

  let(:banned_user)       { FactoryGirl.create :user, status: "banned" }
  let(:new_user)          { FactoryGirl.create :user, status: "new" }
  let!(:invitation)       { FactoryGirl.create :invitation } # , inviting: other_user, invited: user }
  let(:user)              { invitation.invited  }
  let(:other_user)        { invitation.inviting }

  before(:each) do
    sign_in(user)
  end

  describe "GET 'index'" do
    it "show all invitations" do
      get 'index'
      response.should be_success
      response.should render_template ("layouts/user")
      response.should render_template ("invitations/index")
      assigns(:invitations).should include(invitation)
    end
  end

  describe "POST 'create'" do
    it "should send only one invitation to friends for other user" do
      -> { post :create, person_id: other_user }.should change(Invitation, :count).by(1)
      response.should be_redirect
      -> { post :create, person_id: user }.should_not change(Invitation, :count)
    end
  end

  describe "POST 'training'" do
    context "coach" do
      it "should send invitation to training for user" do
        User.any_instance.stub(:coach).and_return(true)
        -> { post :training, person_id: other_user }.should change(Invitation, :count).by(1)
        Invitation.order("created_at desc").first.training.should be_present
        -> { post :training, person_id: other_user }.should_not change(Invitation, :count)
      end
    end

    context "not coach" do
      it "shouldn't send training invitation" do
        User.any_instance.stub(:coach).and_return(false)
        -> { post :training, person_id: other_user }.should_not change(Invitation, :count)
      end
    end
  end

  describe "PUT 'update'" do
    context "friendships" do
      before(:each) { Invitation.any_instance.stub(:friend).and_return(true) }

      describe "accept invitation" do
        it "should create friendship" do
          -> {
            put :update, id: invitation, invitation: { status: "accepted" }
          }.should change(Friendship, :count).by(1)
          invitation.reload.status.should == "accepted"
        end
      end

      describe "reject invitation" do
        it "shouldn't create Friendship" do
          -> {
            put :update, id: invitation, invitation: { status: "rejected" }
          }.should_not change(Friendship, :count)
          invitation.reload.status.should == "rejected"
        end
      end
    end

    context "trainings" do
      before(:each) { Invitation.any_instance.stub(:training).and_return(true) }

      describe "accept invitation" do
        it "should create training" do
          -> {
            put :update, id: invitation, invitation: { status: "accepted" }
          }.should change(Training, :count).by(1)
          invitation.reload.status.should == "accepted"
        end
      end

      describe "reject invitation" do
        it "shouldn't create training" do
          -> {
            put :update, id: invitation, invitation: { status: "rejected" }
          }.should_not change(Training, :count)
          invitation.reload.status.should == "rejected"
        end
      end
    end


  end
end
