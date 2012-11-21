class Admin::AdminController < AuthenticatedController
	
	skip_before_filter :auth_user

end
