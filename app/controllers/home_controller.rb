class HomeController < ApplicationController

  layout "home"

  def index
  end

  protected

  def auth_user
    redirect_to board_path if user_signed_in?
  end

end
