require 'spec_helper'

describe SearchController do

  let!(:user)  { FactoryGirl.create :user }
  let!(:coach) { FactoryGirl.create(:coach, city: "New York") }
  let!(:user_discipline) { FactoryGirl.create(:user_discipline, user: coach) }
  let!(:discipline) { user_discipline.discipline }
  let!(:place) { FactoryGirl.create(:place) }
  let!(:place_discipline) { FactoryGirl.create(:place_discipline, discipline: discipline, place: place) }
  let!(:location) { FactoryGirl.create(:location, place: place) }

  before(:each) do
    user.coach = false
    user.save
    user.disciplines << discipline
  end

  sphinx_environment :users do
    describe "GET 'index'" do
      it "should render success with views" do
        get :index
        response.should be_success
        response.should render_template ("search/index")
      end

      describe "search" do
        before(:each) do
          ThinkingSphinx::Test.index
          sleep(0.5)
        end

        describe "coach" do
          it "search by city and disciplines" do
            get :index, user: { city: coach.city, discipline_ids: [discipline.id, ""] }
            assigns(:coaches).should == [coach]
          end

          it "search by city" do
            get :index, user: { city: coach.city, discipline_ids: ["", ""] }
            assigns(:coaches).should == [coach]
          end

          it "search by disciplines" do
            get :index, user: { city: "", discipline_ids: [discipline.id, ""] }
            assigns(:coaches).should == [coach]
          end
        end

        describe "place" do
          it "should search by city" do
            get :index, place: {}, location: { city: location.city }
            assigns(:places).should include(place)
          end

          it "should search by name" do
            get :index, place: { name: place.name }, location: {}
            assigns(:places).should include(place)
          end

          it "should search by all parameters" do
            get :index, place: { name: place.name }, location: { city: location.city }
            assigns(:places).should include(place)
          end
        end

        context "user" do
          it "should search by user first name" do
            get :index, search: user.first_name
            assigns(:users).should == [user]
          end

          it "should search by user last name" do
            get :index, search: user.last_name
            assigns(:users).should == [user]
          end

          it "should search by user name" do
            get :index, search: user.name
            assigns(:users).should == [user]
          end

          it "should search by user city and discipline" do
            get :index, discipline: discipline.name, city: user.city
            assigns(:users).should == [user]
          end

          it "should search by user city" do
            get :index, city: user.city
            assigns(:users).should == [user]
          end

          it "should search by user discipline" do
            get :index, discipline: discipline.name
            assigns(:users).should == [user]
          end

          it "return empty array if nothing search" do
            get :index
            assigns(:users).should be_blank
            response.should be_success
          end

          it "shouldn't search banned user" do
            user2 = FactoryGirl.create(:user, status: "banned", first_name: "Paul")
            get :index, search: user2.first_name
            assigns(:users).should be_empty
          end
        end
      end
    end

    describe "GET 'find'" do
      it "returns http success" do
        get 'find'
        assigns(:users).should be_blank
        response.should be_success
      end
    end
  end
end
