require "spec_helper"

describe "Authentication" do

  it "sign up" do
    visit root_path
    fill_in "user_email", with: "other_user@example.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Sign up"
    current_path.should == complete_path
    page.has_content?("Welcome! You have signed up successfully.").should be_true
    fill_in "First name", with: "Peter"
    fill_in "Last name", with: "Jones"
    fill_in "Phone", with: "+48 123 456 789"
    select_date Date.parse('01-01-1960'), :from => "user_birth"
    select "Poland", from:  "user_country"
    fill_in "City", with: "Cracow"
    click_button "Save"
    current_path.should == board_path
    # page.has_content?("Welcome Peter").should be_true
  end

  it "sign in" do
    sign_in
  end

  it "sign out" do
    sign_in
    click_link "Logout"
    current_path.should == root_path
  end
end