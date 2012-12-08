require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create :user }

  describe "associations" do
    let(:other_user) { FactoryGirl.create :user }
    before(:each) { user.invited << other_user }

    it "should send invitations" do
      user.invited.should include(other_user)
    end

    it "should get invitations" do
      other_user.inviting.should include(user)
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

  describe "validate" do
    describe "birth date" do
      it "should be before today" do
        user.should be_valid
        user.birth = Date.today + 2.day
        user.should_not be_valid
      end
    end
  end

  describe "#active!" do
    it "should activate user" do
      user = FactoryGirl.create :user, status: ""
      user.status.should == "new"
      user.active!
      user.status.should == "active"
    end
  end

  describe "#name" do
    it "should return user full name" do
      user.name.should == "#{user.first_name} #{user.last_name}"
    end
  end

end