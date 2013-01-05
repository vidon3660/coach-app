require 'spec_helper'

describe Player do

  let(:player) { FactoryGirl.build :player }

  describe "validate" do
    describe "birth date" do
      it "should be before today" do
        player.should be_valid
        player.birth = Date.today + 2.day
        player.should_not be_valid
      end
    end
  end

  describe "#name" do
    it "should return player full name" do
      player.name.should == "#{player.first_name} #{player.last_name}"
    end
  end

end
