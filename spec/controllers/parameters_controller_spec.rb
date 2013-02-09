require 'spec_helper'

describe ParametersController do

  let!(:user)   { FactoryGirl.create :user }
  before(:each) { sign_in(user) }

  describe "POST 'create'" do
    it "should create new user parameters" do
      -> { post :create, parameter: { height: "180", weight: "70"} }.should change(user.parameters, :count).by(1)
      response.should be_redirect
    end
  end

end
