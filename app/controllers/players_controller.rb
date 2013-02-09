class PlayersController < AuthenticatedController

  def show
    @user = User.find(params[:id])
  end

end
