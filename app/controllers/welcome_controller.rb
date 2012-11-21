class WelcomeController < ApplicationController

  layout "welcome"

  def index
  end

  protected

  def auth_user
    redirect_to root_path if user_signed_in?
  end

end
