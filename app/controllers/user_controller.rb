class UserController < AuthenticatedController

  before_filter :check_banned_user

  protected

  def auth_user
    redirect_to welcome_path unless user_signed_in?
  end

  def check_banned_user
    redirect_to banned_path if current_user.banned?
  end

end