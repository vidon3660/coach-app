require 'spec_helper'

describe "Search" do
  let!(:user) { FactoryGirl.create :user }

  sphinx_environment :users do
    before(:each) do
      ThinkingSphinx::Test.index
      sleep(0.5)
      sign_in user
    end

    describe "users" do
      it "should search by user first name" do
        fill_in "search", with: user.player.first_name
      end

      after(:each) do
        click_button "Search"
        current_path.should == search_path
        page.has_content?(user.player.name).should be_true
        click_link user.player.name
        current_path.should == person_path(user)
      end
    end
  end
end