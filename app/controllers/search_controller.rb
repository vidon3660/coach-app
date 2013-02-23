class SearchController < AuthenticatedController

  def index
    # TODO: Thinking sphinx here!
    if params[:search]
      # @users = User.search params[:search], order: :last_name, conditions: { status: "active" }
      @users = User.active.where("first_name like ? or last_name like ?", params[:search], params[:search]).order(:last_name)
    end
  end

  def find
    # TODO: Thinking sphinx here!
    @users = []
    if params[:user]
      @users = User.custom_search(params[:user])
    end
  end

end