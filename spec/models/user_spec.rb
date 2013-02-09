require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create :user }
  let(:other_user) { FactoryGirl.create :user }

  describe "associations" do
    before(:each) { user.invited_users << other_user }

    it "should send invitations" do
      user.invited_users.should include(other_user)
      other_user.invited_users.should_not include(user)
    end

    it "should get invitations" do
      other_user.inviting_users.should include(user)
      user.inviting_users.should_not include(other_user)
    end

    it "should has contacts created by self" do
      user.direct_friends << other_user
      user.friends.should include(other_user)
      other_user.friends.should include(user)
    end
  end

  describe "status" do
    it "should has available statuses" do
      ["new", "active", "banned"].each do |status|
        user.status = status
        user.should be_valid
      end
    end

    it "should set status 'new' for active user haven't signed yet" do
      user = FactoryGirl.create :user, status: ""
      user.status.should == "new"
    end

    it "shouldn't set status after create if status exist" do
      user.status.should == "active"
    end
  end

  describe "#active!" do
    it "should activate user" do
      user = FactoryGirl.create :user, status: ""
      user.status.should == "new"
      user.active!
      user.status.should == "active"
      user.should be_active
    end
  end

  describe "validate" do
    describe "birth date" do
      it "should be before today" do
        user.should be_valid
        user.birth = Date.today + 2.day
        user.should_not be_valid
      end
    end
  end

  describe "#name" do
    it "should return user full name" do
      user.name.should == "#{user.first_name} #{user.last_name}"
    end
  end

end