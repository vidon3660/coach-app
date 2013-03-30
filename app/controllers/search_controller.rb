class SearchController < AuthenticatedController

  def index
    @users = []
    # TODO: Thinking sphinx here!
    if params[:search]
      # @users = User.search params[:search], order: :last_name, conditions: { status: "active" }
      @users = User.active.where("first_name like ? or last_name like ?", params[:search], params[:search]).order(:last_name)
    end
  end

  def find
    # TODO: Thinking sphinx here!
    @users = []
    @places = []

    if params[:user]
      @users = User.custom_search(params[:user])
    end

    if params[:location] && params[:place]
      if params[:location][:city].present? && params[:place][:name].present?
        @places = Place.joins(:location).where("locations.city = ?", params[:location][:city]).where(name: params[:place][:name])
        # end
      elsif params[:location][:city].present?
        @places = Place.joins(:location).where("locations.city = ?", params[:location][:city])
      elsif params[:place][:name].present?
        @places = Place.where(name: params[:place][:name])
      end
    end
  end

end