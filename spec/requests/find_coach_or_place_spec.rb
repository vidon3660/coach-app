require "spec_helper"

describe "Find coach or place" do

  let!(:user)       { FactoryGirl.create(:user) }
  let!(:coach)      { FactoryGirl.create(:coach) }

  let!(:discipline) { FactoryGirl.create :discipline }
  let!(:place) { FactoryGirl.create :place }

  let!(:user_discipline) { FactoryGirl.create(:user_discipline, user: coach, discipline: discipline) }
  let!(:discipline_place) { FactoryGirl.create(:discipline_place, discipline: discipline, place: place) }
  let!(:location) { FactoryGirl.create(:location, place: place) }

  before(:each) do
    sign_in user
    click_link "Find coach or place"
    current_path.should == find_path
  end

  context "search coach" do
    before(:each) { page.has_content?(coach.name).should be_false }

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

  context "search place" do
    before(:each) { page.has_content?(place.name).should be_false }

    it "should search by city" do
      fill_in "location_city", with: location.city
    end

    it "should search by name" do
      fill_in "place_name", with: place.name
    end

    it "should search by all params" do
      fill_in "location_city", with: location.city
      fill_in "place_name", with: place.name
    end

    after(:each) do
      click_button "place_search"
      current_path.should == find_path
      page.has_content?(place.name).should be_true
    end
  end
end