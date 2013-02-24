require 'spec_helper'

describe SearchController do

  let(:user) { FactoryGirl.create :user }
  before(:each) { sign_in(user) }

  sphinx_environment :users do
    describe "GET 'index'" do
      it "should render success with views" do
        get :index
        response.should be_success
        response.should render_template ("layouts/user")
        response.should render_template ("search/index")
      end

      describe "search" do
        before(:each) do
          ThinkingSphinx::Test.index
          sleep(0.5)
        end

        context "user" do
          it "should search by user first name" do
            get :index, search: user.first_name
            assigns(:users).should include(user)
          end

          it "should search by user last name" do
            get :index, search: user.last_name
            assigns(:users).should include(user)
          end

          it "should search by user name" do
            pending "to work this should be run in thinking sphinx"
            get :index, search: user.name
            assigns(:users).should include(user)
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
      let!(:coach)      { FactoryGirl.create(:coach, city: "New York") }
      let!(:user_discipline) { FactoryGirl.create(:user_discipline, user: coach) }
      let!(:discipline) { user_discipline.discipline }
      let!(:place) { FactoryGirl.create(:place) }
      let!(:place_discipline) { FactoryGirl.create(:place_discipline, discipline: discipline, place: place) }
      let!(:location) { FactoryGirl.create(:location, place: place) }

      it "returns http success" do
        get 'find'
        assigns(:users).should be_blank
        response.should be_success
      end

      describe "search coach" do
        it "search by city and disciplines" do
          get 'find', user: { city: coach.city, discipline_ids: [discipline.id, ""] }
          assigns(:users).should == [coach]
        end

        it "search by city" do
          get 'find', user: { city: coach.city, discipline_ids: ["", ""] }
          assigns(:users).should == [coach]
        end

        it "search by disciplines" do
          get 'find', user: { city: "", discipline_ids: [discipline.id, ""] }
          assigns(:users).should == [coach]
        end
      end

      describe "search place" do
        it "should search by city" do
          get 'find', place: {}, location: { city: location.city }
          assigns(:places).should include(place)
        end

        it "should search by name" do
          get 'find', place: { name: place.name }, location: {}
          assigns(:places).should include(place)
        end

        it "should search by all parameters" do
          get 'find', place: { name: place.name }, location: { city: location.city }
          assigns(:places).should include(place)
        end
      end
    end
  end
end
