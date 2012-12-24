class BannedController < AuthenticatedController

  skip_before_filter :check_banned_user
  layout false

  def index
  end

end
