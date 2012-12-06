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
            get :index, search: user.name
            assigns(:users).should include(user)
          end

          it "return empty array if nothing search" do
            get :index
            assigns(:users).should be_blank
            response.should be_success
          end

          it "shouldn't search banned user" do
            user.update_attribute(:status, "banned")
            get :index, search: user.name
            assigns(:users).should be_blank
          end
        end
      end
    end
  end
end
