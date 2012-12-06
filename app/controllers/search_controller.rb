class SearchController < AuthenticatedController

  def index
    @users = User.search params[:search], order: :first_name, conditions: { status: "active" }
  end

end