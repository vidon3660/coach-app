require 'spec_helper'

describe "Search" do
  let!(:user) { FactoryGirl.create :user }

  sphinx_environment :users do
    before(:each) do
      ThinkingSphinx::Test.index
      sleep(0.5)
      visit root_path
      sign_in user
    end

    describe "users" do
      it "should search by user first name" do
        fill_in "search", with: user.first_name
      end

      after(:each) do
        click_button "Search"
        current_path.should == search_path
        page.has_content?(user.name).should be_true
        click_link user.name
        current_path.should == person_path(user)
      end
    end
  end
end