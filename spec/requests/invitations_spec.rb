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

    it "should send invitation to friends" do
      click_button "Add to friends"
      current_path.should == player_path(other_user)
      page.has_content?("Invitation to friend sent successfully.").should be_true
    end

    it "should send send invitation to training" do
      click_button "Add to training"
      current_path.should == player_path(other_user)
      page.has_content?("Invitation to training sent successfully.").should be_true
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

    it "accept invitation" do
      # Make friends method in invitation and destroy invitation
      click_button "Accept"
      current_path.should == invitations_path
      page.has_content?("You add #{invitation.inviting.name} to your friends.").should be_true
    end

    it "reject invitation" do
      # destroy invitation
      click_button "Reject"
      current_path.should == invitations_path
      page.has_content?("You reject invitation.").should be_true
    end
  end
end
