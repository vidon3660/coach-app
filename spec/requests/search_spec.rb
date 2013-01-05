require 'spec_helper'

describe "Search" do
  let!(:user)  { FactoryGirl.create :user }
  let(:player) { user.player }

  sphinx_environment :users do
    before(:each) do
      ThinkingSphinx::Test.index
      sleep(0.5)
      sign_in user
    end

    describe "users" do
      it "should search by user first name" do
        fill_in "search", with: player.first_name
      end

      after(:each) do
        click_button "Search"
        current_path.should == search_path
        page.has_content?(player.name).should be_true
        click_link player.name
        current_path.should == player_path(player)
      end
    end
  end
end