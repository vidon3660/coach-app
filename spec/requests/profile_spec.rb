require "spec_helper"

describe "User profile" do

  let(:prohibition)   { FactoryGirl.create(:prohibition) }

  before(:each) do
    sign_in
    click_link "Profile"
    current_path.should == profile_path
  end

  it "change password" do
    click_link "Password"
    current_path.should == edit_user_registration_path
    fill_in "Current password", with: @user.password
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"
    click_button "Save"
    current_path.should == edit_user_registration_path
    page.has_content?("You updated your account successfully.").should be_true
  end

  describe "change user informations" do
    before(:each) do
      prohibition.save
      click_link "Informations"
      current_path.should == profile_informations_path
    end

    it "should change personal informations" do
      fill_in "First name", with: "Peter"
      fill_in "Last name", with: "Jones"
      fill_in "Phone", with: "+48 123 456 789"
      select_date Date.parse('01-01-1960'), :from => "user_birth"
      select "Poland", from: "user_country"
      fill_in "City", with: "Cracow"
      click_button "Save"
      current_path.should == profile_informations_path
      page.has_content?("You updated your account successfully.").should be_true
    end
  end

  describe "user public profile" do
    let(:parameter)     { FactoryGirl.create(:parameter) }
    let!(:other_user)   { FactoryGirl.create(:user) }

    before(:each) do
      @user.stub(:coach).and_return(true)

      @user.trained_users         << other_user
      other_user.prohibitions     << prohibition
      other_user.parameters       << parameter

      visit player_path(other_user)
      current_path.should == player_path(other_user)
    end

    it "show user public profile" do
      page.has_content?(other_user.first_name).should be_true
      page.has_content?(other_user.last_name).should be_true
      page.has_content?(other_user.city).should be_true
    end

    context "user is coach" do
      it "show user prohibitions" do
        page.has_content?(prohibition.name).should be_true
      end

      it "show user parameters" do
        page.has_content?(parameter.height.to_s).should be_true
        page.has_content?(parameter.weight.to_s).should be_true
      end
    end
  end
end
