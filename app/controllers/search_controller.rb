class SearchController < AuthenticatedController

  def index
    if params[:search]
      @users = User.search params[:search], order: :last_name, conditions: { status: "active" }
    end
  end

end