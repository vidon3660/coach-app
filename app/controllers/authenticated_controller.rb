class AuthenticatedController < ApplicationController

  layout :layout_by_resource

  before_filter :authenticate_user!
  before_filter :check_banned_user

  helper_method :current_player

  protected

	  def layout_by_resource
	    if devise_controller?
        "authentication"
      elsif user_signed_in?
       "user"
	    end
	  end

  private

    def current_player
      current_user.player
    end

    def check_banned_user
      redirect_to banned_path if current_user.banned?
    end

    def auth_user
      redirect_to root_path unless user_signed_in?
    end

end