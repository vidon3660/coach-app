require "spec_helper"

describe "Admin panel" do

  before(:each) do
    visit admin_root_path
    current_path.should == new_user_session_path
  end

  describe "user is admin" do
    let!(:admin) { FactoryGirl.create :admin }

    it "should sign in" do
      fill_in "Email", with: admin.email
      fill_in "Password", with: admin.password
      click_button "Login"
      current_path.should == admin_root_path
    end
  end

  describe "user isn't admin" do
    let!(:user) { FactoryGirl.create :user }

    it "sholdn't sign in" do
      pending "contrinue when specify roles"
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
      current_path.should == root_path
    end
  end

end