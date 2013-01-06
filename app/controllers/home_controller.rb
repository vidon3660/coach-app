class HomeController < ApplicationController

  layout false

  def index
    @user = User.new
  end

  protected

  def auth_user
    redirect_to board_path if user_signed_in?
  end

end
