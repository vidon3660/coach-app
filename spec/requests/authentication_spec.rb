    require "spec_helper"

describe "Authentication" do

  it "sign up" do
    visit root_path
    click_link "Sign up"
    current_path.should == new_user_registration_path
    fill_in "Email", with: "other_user@example.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Sign up"
    current_path.should == complete_path
    page.has_content?("Welcome! You have signed up successfully.").should be_true
    fill_in "First name", with: "Peter"
    fill_in "Last name", with: "Jones"
    fill_in "Phone", with: "+48 123 456 789"
    select_date Date.parse('01-01-1960'), :from => "player_birth" 
    select "Poland", from:  "player_country"
    fill_in "City", with: "Cracow"
    fill_in "Address", with: "Wawel"
    click_button "Save"
    current_path.should == board_path
    page.has_content?("Welcome Peter Jones").should be_true
  end

  it "sign in" do
    sign_in
  end

  it "sign out" do
    sign_in
    click_link "Logout"
    current_path.should == root_path
    page.has_content?("Signed out successfully.").should be_true
  end
end