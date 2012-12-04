class AuthenticatedController < ApplicationController
	
  before_filter :authenticate_user!
  before_filter :check_banned_user

  private

    def check_banned_user
      redirect_to banned_path if current_user.banned?
    end

end