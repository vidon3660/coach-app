require 'spec_helper'

describe CalendarsController do
  let(:user)   { FactoryGirl.create :user, status: "new" }
  
  before(:each) { sign_in(user) }
  
  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
