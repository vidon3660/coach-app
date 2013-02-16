require 'spec_helper'

describe MessagesController do

  let!(:user)              { FactoryGirl.create :user  }
  let!(:user2)             { FactoryGirl.create :user  }

  let!(:message)           { FactoryGirl.create :message, sender: user2, recipient: user }
  let!(:message2)          { FactoryGirl.create :message, sender: user, recipient: user2 }

  before(:each) do
    sign_in(user)
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      assigns(:messages).should == [message]
      response.should be_success
    end
  end

  describe "GET 'sent'" do
    it "returns http success" do
      get :sent
      assigns(:messages).should == [message2]
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get :show, id: message.id
      assigns(:message).should == message
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "returns http success" do
      get :new, person_id: user2.id
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "should create new message" do
      -> {
        post :create, person_id: user2.id, message: { subject: "a subject", body: "bla bla bla" }
      }.should change(user2.received_messages, :count).by(1)
      response.should be_redirect
    end
  end

  describe "DELETE 'destroy'" do
    it "should remove message for sender" do
      message.reload.recipient_deleted.should be_false
      delete :destroy, id: message.id
      message.reload.recipient_deleted.should be_true
    end
  end

end
