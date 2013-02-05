require "spec_helper"

describe "Friends invitations" do

  let!(:user)         { FactoryGirl.create(:user) }
  let!(:other_user)   { FactoryGirl.create(:user) }
  let!(:invitation)   { FactoryGirl.create(:invitation, inviting: other_user, invited: user) }

  before(:each) do
    other_user.update_attribute(:first_name, "Paul")
    sign_in user
  end

  describe "send invitation" do
    before(:each) do
      visit player_path(other_user)
      current_path.should == player_path(other_user)
    end

    it "should send invitation to contacts" do
      click_button "Add to friends"
      current_path.should == player_path(other_user)
      page.has_content?("Invitation sent successfully.").should be_true
    end

    it "should send send invitation to training" do
      user.contacts << other_user
      click_button "Add to training"
      current_path.should == player_path(other_user)
      page.has_content?("Add to training successfully.").should be_true
    end
  end

  describe "show invitations" do
    before(:each) do
      click_link "Invitations"
      current_path.should == invitations_path
    end

    it "show all invitations" do
      page.has_content?(invitation.inviting.name).should be_true
    end

    describe "show invitation" do
      before(:each) do
        click_link invitation.inviting.name
        current_path.should == invitation_path(invitation)
      end

      it "show content" do
        page.has_content?(invitation.inviting.name).should be_true
      end

      it "accept" do
        # Make friends method in invitation and destroy invitation
        click_button "Accept"
        current_path.should == invitations_path
        page.has_content?("You add #{invitation.inviting.name} to your contacts.").should be_true
      end

      it "reject" do
        # destroy invitation
        click_button "Reject"
        current_path.should == invitations_path
        page.has_content?("You reject invitation.").should be_true
      end
    end
  end
end
