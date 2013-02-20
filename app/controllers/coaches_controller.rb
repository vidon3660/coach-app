class CoachesController < AuthenticatedController
  def index
    if params[:user] && params[:user][:city].present?
      # TODO: Thinking sphinx here!
      @users = User.coaches.where("city like ?", params[:user][:city]).order(:last_name)
    else
      @users = []
    end
  end
end
