require 'spec_helper'

describe User do

  let(:user) { FactoryGirl.create :user }

  describe "#name" do
    it "should return user full name" do
      user.name.should == "#{user.first_name} #{user.last_name}"
    end
  end

end