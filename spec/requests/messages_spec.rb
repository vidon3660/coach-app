require "spec_helper"

describe "Contacts" do

  let!(:user)              { FactoryGirl.create :user  }
  let!(:user2)             { FactoryGirl.create :user  }

  let!(:message)           { FactoryGirl.create :message, sender: user2, recipient: user }
  let!(:message2)          { FactoryGirl.create :message, sender: user, recipient: user2 }

  before(:each) do
    sign_in user
  end

  describe "show messages" do
    before(:each) do
      click_link "messages"
      current_path.should == messages_path
    end

    it "show all received messages" do
      page.has_content?(message.subject).should be_true
      page.has_content?(message2.subject).should be_false
    end

    it "show all sent messages" do
      click_link "Sent"
      page.has_content?(message2.subject).should be_true
      page.has_content?(message.subject).should be_false
    end

    it "show message" do
      click_link message.subject
      current_path.should == message_path(message)
      page.has_content?(message.subject).should be_true
      page.has_content?(message.body).should be_true
    end

    it "remove message" do
      click_link "remove"
      current_path.should == messages_path
      page.has_content?(message.subject).should be_false
    end
  end

  it "create new message" do
    visit player_path(user2)
    click_link "send message"
    current_path.should == new_person_message_path(user2)
    fill_in "Subject", with: "A new subject"
    fill_in "Body", with: "bla bla bla"
    click_button "Send"
    current_path.should == sent_messages_path
    page.has_content?("A new subject").should be_true
  end
end