class RegistrationsController < Devise::RegistrationsController

  layout :set_layout

  def update
    @user = current_user
    if @user.update_with_password(resource_params)
      sign_in resource_name, @user, :bypass => true
      flash[:notice] = "You updated your account successfully."
      respond_with @user, :location => profile_path
    else
      clean_up_passwords @user
      flash[:alert] = "Something went wrong."
      render "/profile/index"
    end
  end

  private

  def set_layout
    action_name == "update" ? 'application' : 'authentication'
  end

end