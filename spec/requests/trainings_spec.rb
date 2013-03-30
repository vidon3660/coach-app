require 'spec_helper'

describe "Training" do
  let!(:user)         { FactoryGirl.create :user }
  let!(:other_user)   { FactoryGirl.create(:user) }

  let!(:training)   { FactoryGirl.create(:training, coach: user) }
  let!(:training2)  { FactoryGirl.create(:training, user: user) }


  before(:each) do
    sign_in user
  end

  describe "close training" do
    it "as user" do
      visit training_path(training)
    end

    it "as coach" do
      visit training_path(training2)
    end

    after(:each) do
      click_link "Close training"
      current_path.should == root_path
      # TODO:
      # current_path.should == board_path
    end
  end

end