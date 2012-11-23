require "spec_helper"

describe "Coach panel" do

  before(:each) do
    visit coach_root_path
    current_path.should == new_user_session_path
  end

  describe "user is coach" do
    let!(:coach) { FactoryGirl.create :coach }

    it "should sign in" do
      fill_in "Email", with: coach.email
      fill_in "Password", with: coach.password
      click_button "Login"
      current_path.should == coach_root_path
    end
  end

  describe "user isn't coach" do
    let!(:coach) { FactoryGirl.create :coach }

    it "sholdn't sign in" do
      pending "contrinue when specify roles"
      fill_in "Email", with: coach.email
      fill_in "Password", with: coach.password
      click_button "Login"
      current_path.should == root_path
    end
  end

end