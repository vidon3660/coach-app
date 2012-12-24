class ApplicationController < ActionController::Base
	
  protect_from_forgery

  layout :layout_by_resource

  before_filter :auth_user

  protected

  def auth_user
  end

  def after_sign_in_path_for(resource)
    current_user.new? ? complete_url : board_url
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def layout_by_resource
    if devise_controller?
    	"authentication"
    elsif user_signed_in?
      "user"
    end
  end

end
