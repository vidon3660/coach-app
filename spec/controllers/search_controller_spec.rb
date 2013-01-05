require 'spec_helper'

describe SearchController do

  let(:user) { FactoryGirl.create :user }
  let(:player) { user.player }
  before(:each) { sign_in(user) }

  sphinx_environment :players do
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
          it "should search by player first name" do
            get :index, search: player.first_name
            assigns(:players).should include(player)
          end

          it "should search by player last name" do
            get :index, search: player.last_name
            assigns(:players).should include(player)
          end

          it "should search by player name" do
            pending "to work this should be run in thinking sphinx"
            get :index, search: player.name
            assigns(:players).should include(player)
          end

          it "return empty array if nothing search" do
            get :index
            assigns(:players).should be_blank
            response.should be_success
          end

          it "shouldn't search banned user" do
            user2 = FactoryGirl.create(:user, status: "banned") 
            player = user2.player
            player.update_attribute(:first_name, "Paul")
            player.reload
            get :index, search: player.first_name
            assigns(:players).should be_empty
          end
        end
      end
    end
  end
end
