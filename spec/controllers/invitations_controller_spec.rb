require 'spec_helper'

describe InvitationsController do

  let!(:user)       { FactoryGirl.create :user }
  let!(:other_user) { FactoryGirl.create :user }
  let(:banned_user) { FactoryGirl.create :user, status: "banned" }
  let(:new_user)    { FactoryGirl.create :user, status: "new" }
  let!(:invitation) { FactoryGirl.create :invitation, inviting: other_user, invited: user }

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

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: invitation
      response.should be_success
      response.should render_template ("layouts/user")
      response.should render_template ("invitations/show")
      assigns(:invitation).should == invitation
    end
  end

  describe "POST 'create'" do
    it "should send only one invitation to contacts for other user" do
      -> { post :create, person_id: other_user }.should change(Invitation, :count).by(1)
      response.should be_redirect
      -> { post :create, person_id: user }.should_not change(Invitation, :count)
    end

    context "traning" do
      it "should send invitation with training by coach" do
        User.any_instance.stub(:coach).and_return(true)
        post :create, person_id: other_user, training: true
        Invitation.order("created_at desc").first.training.should be_true
      end

      it "shouldn't send invitation by user" do
        User.any_instance.stub(:coach).and_return(false)
        post :create, person_id: other_user, training: true
        Invitation.order("created_at desc").first.training.should be_blank
      end

      it "should send invitation without training" do
        post :create, person_id: other_user
        Invitation.order("created_at desc").first.training.should be_blank
      end
    end
  end

  describe "POST 'training'" do
    context "coach" do
      before(:each) { User.any_instance.stub(:coach).and_return(true) }

      context "to user contact" do
        it "should send invitation to training for exist contact" do
          user.contacts << other_user
          -> { post :training, person_id: other_user }.should_not change(Invitation, :count)
          user.relationships.find_by_contact_id(other_user.id).training.should be_true
          # Invitation.order("created_at desc").first.training.should be_true
        end
      end

      context "to new contact" do
        it "should send invitation to contacts and training for user" do
          -> { post :training, person_id: other_user }.should change(Invitation, :count).by(1)
          Invitation.order("created_at desc").first.training.should be_blank
        end
      end
    end

    context "not coach" do
      before(:each) { User.any_instance.stub(:coach).and_return(false) }

      it "shouldn't send training invitation" do
        -> { post :training, person_id: other_user }.should_not change(Invitation, :count)
      end
    end
  end

  describe "PUT 'update'" do
    describe "accept invitation" do
      it "should create realtionship" do
        -> {
          put :update, id: invitation, invitation: {status: "accepted" }
        }.should change(Relationship, :count).by(2)
      end

      it "should set status for accepted" do
        pending "NOT WORKING!!!"
        invitation = FactoryGirl.create :invitation, inviting: other_user, invited: user
        put :update, id: invitation, invitation: { status: "accepted" }
        invitation.reload.status.should == "accepted"
      end
    end

    describe "reject invitation" do
      it "shouldn't create relationship" do
        -> {
          put :update, id: invitation, invitation: { status: "rejected" }
        }.should change(Relationship, :count).by(0)
      end

      it "should set status for rejected" do
        pending "NOT WORKING!!!"
        put :update, id: invitation, invitation: {status: "rejected" }
        Invitation.first.status.should == "rejected"
      end
    end
  end
end
