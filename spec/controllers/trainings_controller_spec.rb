require 'spec_helper'

describe TrainingsController do

  let!(:user)     { FactoryGirl.create :user }
  let(:training)  { FactoryGirl.create :training }
  before(:each) { sign_in(user) }

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: training.id
      response.should be_success
    end
  end

end
