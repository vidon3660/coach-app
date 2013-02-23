require 'spec_helper'

describe PlacesController do

  let(:user) { FactoryGirl.create :user }
  let(:place) { FactoryGirl.create :place }

  before(:each) { sign_in(user) }

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: place.id
      response.should be_success
    end
  end

end
