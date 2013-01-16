class UserProhibitionsController < AuthenticatedController

  def create
    current_player.prohibitions << Prohibition.find(params[:prohibition])
    redirect_to profile_informations_path
  end

end
