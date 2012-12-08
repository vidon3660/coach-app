class SearchController < AuthenticatedController

  def index
    if params[:search]
      # TODO: Thinking sphinx here!
      # @users = User.search params[:search], order: :last_name, conditions: { status: "active" }

      @users = User.where(status: "active").where("first_name like ? or last_name like ?", params[:search], params[:search]).order(:last_name)
    end
  end

end