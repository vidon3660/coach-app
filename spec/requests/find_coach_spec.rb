require "spec_helper"

describe "Find coach" do

  let!(:user)  { FactoryGirl.create(:user) }
  let!(:coach) { FactoryGirl.create(:coach) }

  before(:each) do
    sign_in user
  end

  describe "search coach" do
    it "should search coach by city" do
      click_link "Find coach or place"
      current_path.should == coaches_path
      page.has_content?(coach.name).should be_false
      fill_in "user_city", with: coach.city
      click_button "user_search"
      current_path.should == coaches_path
      page.has_content?(coach.name).should be_true
    end
  end

end