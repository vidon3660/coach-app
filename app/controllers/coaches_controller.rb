class CoachesController < AuthenticatedController
  def index
    # TODO: Thinking sphinx here!
    @users = []
    if params[:user]
      @users = User.custom_search(params[:user])
    end
  end
end
