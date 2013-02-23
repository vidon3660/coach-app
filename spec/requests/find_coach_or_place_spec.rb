require "spec_helper"

describe "Find coach or place" do

  let!(:user)       { FactoryGirl.create(:user) }
  let!(:coach)      { FactoryGirl.create(:coach) }
  let!(:user_discipline) { FactoryGirl.create(:user_discipline, user: coach) }
  let(:discipline) { user_discipline.discipline }

  before(:each) do
    coach.user_disciplines << user_discipline
    sign_in user
    click_link "Find coach or place"
    current_path.should == find_path
    page.has_content?(coach.name).should be_false
  end

  it "should search coach by city" do
    fill_in "user_city", with: coach.city
    click_button "user_search"
    current_path.should == find_path
    page.has_content?(coach.name).should be_true
  end

  it "should search by discipline" do
    check discipline.name
    click_button "user_search"
    current_path.should == find_path
    page.has_content?(coach.name).should be_true
  end

end