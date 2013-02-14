require 'spec_helper'

describe EventsController do

  let(:user) { FactoryGirl.create :user }
  let(:event)  { FactoryGirl.create :event }
  before(:each) { sign_in(user) }

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: event.id
      response.should be_success
    end
  end

end
