require "spec_helper"

describe "Coach panel" do

  let!(:coach) { FactoryGirl.create :coach }

  before(:each) do
    sign_in
    current_path.should == root_path
  end

  it "should has calendar"

end