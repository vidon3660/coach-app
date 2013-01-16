class ProfileController < AuthenticatedController

  load_and_authorize_resource :user

  def index
  end

  def informations
    @parameters       = current_player.parameters.order("created_at desc")
    @parameter        = Parameter.new
    @prohibitions     = current_player.prohibitions
    @user_prohibition = PlayerProhibition.new
  end

  def update
    if current_player.update_attributes(params[:player])
      redirect_to profile_informations_path, notice: t('devise.registrations.updated')
    else
      render :informations
    end
  end
end
