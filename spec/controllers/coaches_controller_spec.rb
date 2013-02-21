require 'spec_helper'

describe CoachesController do
  let(:user)   { FactoryGirl.create :user }
  let!(:coach)      { FactoryGirl.create(:coach, city: "New York") }
  let!(:user_discipline) { FactoryGirl.create(:user_discipline, user: coach) }
  let(:discipline) { user_discipline.discipline }

  before(:each) { sign_in(user) }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      assigns(:users).should be_blank
      response.should be_success
    end

    describe "search coach" do
      it "search by city and disciplines" do
        get 'index', user: { city: coach.city, discipline_ids: [discipline.id, ""] }
        assigns(:users).should == [coach]
      end

      it "search by city" do
        get 'index', user: { city: coach.city, discipline_ids: ["", ""] }
        assigns(:users).should == [coach]
      end

      it "search by disciplines" do
        get 'index', user: { city: "", discipline_ids: [discipline.id, ""] }
        assigns(:users).should == [coach]
      end
    end
  end

end
