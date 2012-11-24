require 'spec_helper'

describe CompleteController do
  let(:user) { FactoryGirl.create :user } 
  before(:each) { sign_in(user) }
  
  describe "GET 'edit'" do
    it "returns http success" do

      get 'edit'
      response.should be_success
    end
  end

end
