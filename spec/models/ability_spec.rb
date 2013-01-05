require "spec_helper"
require "cancan/matchers"

describe "User" do

  subject { ability }
  let(:ability) { Ability.new(user) }
  let(:user)    { FactoryGirl.create(:user) }

  describe "abilities" do
    describe "update profile" do
      it "should update own profile if is active" do
        ability.should be_able_to(:update, user)
      end

      it "should update own profile if is new" do
        user.status = "new"
        ability.should be_able_to(:update, user)
      end

      it "shouldn't update profile if is banned" do
        user.status = "banned"
        ability.should_not be_able_to(:update, user)
      end

      it "shouldn't update other user profile" do
        ability.should_not be_able_to(:update, User.new)
      end
    end

    describe "index" do
      it "should read own profile if is active" do
        ability.should be_able_to(:index, user)
      end

      it "shouldn't read profile if is banned" do
        user.status = "banned"
        ability.should_not be_able_to(:index, user)
      end

      it "shouldn't read other user profile" do
        ability.should_not be_able_to(:index, User.new)
      end
    end

    describe "show" do
      it "should show active user public profile if is active" do
        ability.should be_able_to(:show, user)
      end

      it "shouldn't show profile if is banned" do
        user.status = "banned"
        ability.should_not be_able_to(:show, user)
      end
    end
  end

end