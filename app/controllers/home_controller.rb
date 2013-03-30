class HomeController < ApplicationController

  def index
    @user = User.new
  end

  protected

  # TODO: Add when we will have training functionality.
  # def auth_user
  #   redirect_to board_path if user_signed_in?
  # end

end
