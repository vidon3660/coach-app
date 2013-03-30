require "spec_helper"

describe BoardController do
  let(:user) { FactoryGirl.create :user }
  before(:each) { sign_in(user) }

  describe "signed user" do
    it "GET 'index'" do
      get :index
      response.should render_template ("board/index")
    end
  end

end