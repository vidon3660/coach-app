require "spec_helper"

describe "User paramters" do

  let!(:prohibition)   { FactoryGirl.create(:prohibition) }

  before(:each) do
    sign_in 
    pending
    click_link "You / Preferences"
    current_path.should == profile_about_path
  end

  it "should change data informations" do
    pending
    select "178", from: "Height"
    select "78", from: "Weight"
    click_button "add_paramterer"
    current_path.should == profile_about_path
    page.has_content?("178").should be_true
    page.has_content?("78").should be_true
  end

  it "should change prohibitions" do
    pending
    @user.prohibitions.should be_blank
    select prohibition.name, from: "prohibition"
    click_button "add_user_prohibition"
    current_path.should == profile_about_path
    page.has_content?(prohibition.name).should be_true
    @user.reload.prohibitions.should_not be_blank
  end

end