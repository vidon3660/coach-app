require 'spec_helper'

describe Invitation do

  let(:user) { FactoryGirl.create :user }
  let(:other_user) { FactoryGirl.create :user }

  describe "validation" do
    let(:invitation) { FactoryGirl.build :invitation, inviting: user, invited: other_user }

    it "should send only one invitation to user" do
      invitation.should be_valid
      -> { invitation.save }.should change(Invitation, :count).by(1)
      next_invitation = FactoryGirl.build :invitation, inviting: user, invited: other_user
      next_invitation.should_not be_valid
      next_invitation.errors[:invited].should include("You've sent invitation yet.")
    end

    it "shouldn't send invitation to self" do
      invitation = FactoryGirl.build :invitation, inviting: user, invited: user
      invitation.should_not be_valid
      invitation.errors[:invited].should include("You can't send invitation to yourself.")
    end
  end
end
