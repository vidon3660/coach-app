require "spec_helper"

describe "User profile" do
  before(:each) do
    visit root_path
    sign_in
    click_link "Profile"
    current_path.should == profile_path
  end

  it "change password" do
    click_link "Password"
    current_path.should == edit_user_registration_path
    fill_in "Current password", with: @user.password
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Save"
    current_path.should == edit_user_registration_path
    page.has_content?("You updated your account successfully.").should be_true
  end

  it "change user informations" do
    click_link "Informations"
    current_path.should == profile_informations_path
    fill_in "First name", with: "Peter"
    fill_in "Last name", with: "Jones"
    fill_in "Phone", with: "+48 123 456 789"
    select_date Date.parse('01-01-1960'), :from => "user_birth"
    select "Poland", from:  "Country"
    fill_in "City", with: "Cracow"
    fill_in "Address", with: "Wawel"
    click_button "Save"
    current_path.should == profile_informations_path
    page.has_content?("You updated your account successfully.").should be_true
  end
end