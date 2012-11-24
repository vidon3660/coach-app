class ApplicationController < ActionController::Base
	
  protect_from_forgery

  layout :layout_by_resource

  before_filter :auth_user

  protected

  def auth_user
  end

  def after_sign_in_path_for(resource)
    current_user.is_new? ? complete_url : super
  end

  def after_sign_out_path_for(resource)
    welcome_path
  end

  def layout_by_resource
    if devise_controller?
    	"authentication"
    elsif user_signed_in?
      "application"
    end
  end

end
