class PlayersController < AuthenticatedController

  def show
    @player = Player.find(params[:id])
  end

end
