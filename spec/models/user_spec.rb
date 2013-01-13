require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create :user }
  let(:other_user) { FactoryGirl.create :user }

  describe "associations" do
    before(:each) { user.invited << other_user }

    it "should send invitations" do
      user.invited.should include(other_user)
      other_user.invited.should_not include(user)
    end

    it "should get invitations" do
      other_user.inviting.should include(user)
      user.inviting.should_not include(other_user)
    end

    it "should has contacts created by self" do
      user.contacts << other_user
      user.contacts.should include(other_user)
      other_user.contacts.should_not include(user)
    end
  end

  describe "roles" do
    let(:roles) { %w[admin coach user] }

    it "should has all roles after create (temporary, while application is before first public release)" do
      user.roles.should == roles
    end

    it "should has available roles" do
      user.roles = roles
      user.roles.should == roles

      roles = %w[bad_role]
      user.roles = roles
      user.roles.should be_empty
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

  describe "player" do
    it "create player for user after create user" do
      user = User.new(email: "user@example.com", password: "password")
      user.player.should be_blank
      user.save
      user.player.should be_present
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

end