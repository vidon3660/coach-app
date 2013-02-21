class CoachesController < AuthenticatedController
  def index
    # TODO: Thinking sphinx here!
    @users = User.custom_search(params[:user])
  end
end
