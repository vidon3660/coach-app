class RegistrationsController < Devise::RegistrationsController

  layout "user", only: :edit

  protected

    def after_update_path_for(resource)
      edit_user_registration_path
    end

end