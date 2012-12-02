require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create :user }

  describe "status" do
    it "should has available statuses" do
      user.status = "banned"
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
    let(:user) { FactoryGirl.build :user }

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

  describe "#update_attributes" do
    it "should set status to active if actualy status is 'new' and update successful" do
      user = FactoryGirl.create :user, status: ""
      user.status.should == "new"
      user.update_attributes(first_name: "Peter")
      user.reload
      user.status.should == "active"
    end

    it "shouldn't set status to active if actualy status is 'new' and update failed" do
      user = FactoryGirl.create :user, status: ""
      user.status.should == "new"
      user.update_attributes(birth: Date.today + 2.day)
      user.reload
      user.status.should == "new"
    end
  end

end