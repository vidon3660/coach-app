class Admin::AdminController < AuthenticatedController
	
  layout "admin"

  skip_before_filter :auth_user

end
