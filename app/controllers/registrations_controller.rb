class RegistrationsController < Devise::RegistrationsController

  layout "user", only: :edit

  helper_method :current_player

  protected

    def current_player
      @current_user.player
    end

    def after_update_path_for(resource)
      edit_user_registration_path
    end

end