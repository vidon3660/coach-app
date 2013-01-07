def sign_in(user=nil)
  @user = user ? user : FactoryGirl.create(:user)

  visit root_path
  click_link "Login"
  current_path.should == new_user_session_path
  fill_in "user_email", with: @user.email
  fill_in "user_password", with: @user.password
  click_button "Login"
  current_path.should == board_path
  page.has_content?("Signed in successfully.").should be_true
end