class ApplicationController < ActionController::Base
	
  protect_from_forgery

  layout :layout

  before_filter :auth_user

  protected

  def auth_user
  end

  def after_sign_in_path_for(resource)
    # admin isn't user, so we check user type here.
    if current_user
      # TODO: redirect to board url when training will be exist
      # current_user.new? ? complete_url : board_url
      current_user.new? ? complete_url : root_url
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private

  def layout
    devise_controller? ? 'authentication' : "application"
  end

  
end
