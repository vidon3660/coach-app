def sign_in(user=nil)
	@user = user ? user : FactoryGirl.create(:user)

	click_link "Login"
	current_path.should == new_user_session_path
	fill_in "Email", with: @user.email
	fill_in "Password", with: @user.password
	click_button "Login"
	current_path.should == root_path
	page.has_content?("Signed in successfully.").should be_true
end