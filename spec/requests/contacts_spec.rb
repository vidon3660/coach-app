require "spec_helper"

describe "Contacts" do

  let!(:user) { FactoryGirl.create(:user) }
  let!(:other_user) { FactoryGirl.create(:user, first_name: "Paul") }
  let!(:relationship) { FactoryGirl.create(:relationship, user: user, contact: other_user) }

  before(:each) do
    sign_in user
  end

  describe "show contacts" do
    before(:each) do
      click_link "Contacts"
      current_path.should == contacts_path
    end

    it "show all contacts" do
      page.has_content?(other_user.name).should be_true
    end

    it "show contact" do
      click_link other_user.name
      current_path.should == person_path(other_user)
      page.has_content?(other_user.name).should be_true
    end
  end
end