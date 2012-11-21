class UserController < AuthenticatedController

  protected

  def auth_user
    redirect_to welcome_path unless user_signed_in?
  end

end