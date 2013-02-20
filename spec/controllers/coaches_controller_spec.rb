require 'spec_helper'

describe CoachesController do
  let(:user)   { FactoryGirl.create :user }
  
  before(:each) { sign_in(user) }

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

end
