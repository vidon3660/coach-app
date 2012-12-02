class BannedController < UserController

  skip_before_filter :check_banned_user

  def index
  end

end
