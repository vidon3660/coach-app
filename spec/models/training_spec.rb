require 'spec_helper'

describe Training do

  let(:training)  { FactoryGirl.create(:training ) }
  let(:training2) { FactoryGirl.create(:training, close_at: DateTime.now ) }

  describe "scopes" do
    it "should return open trainings" do
      Training.open.should == [training]
    end

    it "should return closed trainings" do
      Training.closed.should == [training2]
    end
  end
end
