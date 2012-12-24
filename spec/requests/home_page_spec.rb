require "spec_helper"

describe "Home page" do

  before(:each) do
    visit root_path
  end

  it "show welcome page for unsigned user" do
    current_path.should == root_path
  end

  it "redirect to root page if user is signed" do
    sign_in
    current_path.should == board_path
    visit root_path
    current_path.should == board_path
  end
end