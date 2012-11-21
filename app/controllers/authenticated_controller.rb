class AuthenticatedController < ApplicationController
	
  before_filter :authenticate_user!

  protected

  def auth_user
    redirect_to welcome_path unless user_signed_in?
  end

end