require 'spec_helper'

describe Invitation do

  let(:user)       { FactoryGirl.create :user }
  let(:other_user) { FactoryGirl.create :user }
  let(:invitation) { FactoryGirl.build :invitation, inviting: user, invited: other_user }
  let(:training)   { FactoryGirl.build :invitation, inviting: user, invited: other_user, training: true }

  describe "validation" do

    context "should send only one invitation to user" do
      before(:each) do
        invitation.should be_valid
        -> { invitation.save }.should change(Invitation, :count).by(1)
      end

      it "should send only one friend invitaiton to user" do
        next_invitation = FactoryGirl.build :invitation, inviting: user, invited: other_user
        next_invitation.should_not be_valid
        next_invitation.errors[:invited].should include("You've sent invitation yet.")
      end

      it "should send friend invitaiton and next training invitation to user" do
        training.should be_valid
      end
    end

    it "shouldn't send invitation to self" do
      invitation = FactoryGirl.build :invitation, inviting: user, invited: user
      invitation.should_not be_valid
      invitation.errors[:invited].should include("You can't send invitation to yourself.")
    end
  end

  describe "status" do
    it "should has available statuses" do
      ["accepted", "expectant", "rejected"].each do |status|
        invitation.status = status
        invitation.should be_valid
      end
    end

    it "should set status 'waiting' for new invitation" do
      invitation = FactoryGirl.create :invitation, inviting: user, invited: other_user, status: ""
      invitation.should be_expectant
    end
  end

  describe "#make_relationship" do
    it "should create relationship for accepted invitation" do
      -> { invitation.make_relationship }.should change(Relationship, :count).by(2)

      user.contacts.should        include(other_user)
      other_user.contacts.should  include(user)
    end

    context "trained" do
      before(:each) { invitation.update_attribute(:training, true) }

      it "should create training relationship" do
        -> { invitation.make_relationship }.should change(Trained, :count).by(1)
        trained = Trained.order("created_at desc").first

        user.trained_users.should      include(other_user)
        other_user.coach_players.should  include(user)

        user.trained_users.should_not      include(user)
        other_user.coach_players.should_not  include(other_user)
      end
    end

    it "shouldn't create relationship for rejected invitation"
    it "shouldn't create relationship for expectant invitation"
    it "shouldn't duplicate relationship"
  end

end
