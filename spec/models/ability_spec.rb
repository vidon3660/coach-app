require "spec_helper"
require "cancan/matchers"

describe "User" do

  subject { ability }
  let(:ability){ Ability.new(user) }
  let(:user){ FactoryGirl.create(:user) }


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

    describe "read" do
      it "should read own profile if is active" do
        ability.should be_able_to(:read, user)
      end

      it "shouldn't read profile if is banned" do
        user.status = "banned"
        ability.should_not be_able_to(:read, user)
      end

      it "shouldn't read other user profile" do
        ability.should_not be_able_to(:read, User.new)
      end
    end
  end

end