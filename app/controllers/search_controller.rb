class SearchController < AuthenticatedController

  def index
    @coaches = []
    @users = []
    @places = []

    if params[:search].present?
      results = User.search(params[:search], order: :last_name, conditions: { status: "active" })
      if results
        @coaches = results.select { |u| u.coach? }
        @users = results.reject   { |u| u.coach? }
      end
    end

    if params[:city].present? && params[:discipline].present?
      results = User.active.joins(:disciplines).where("disciplines.name like ? and users.city like ?", params[:discipline], params[:city]).uniq
      if results
        @coaches = results.select { |u| u.coach? }
        @users = results.reject   { |u| u.coach? }
      end
    elsif params[:city].present?
      results = User.active.where("city like ?", params[:city])
      if results
        @coaches = results.select { |u| u.coach? }
        @users = results.reject   { |u| u.coach? }
      end
    elsif params[:discipline].present?
      results = User.active.joins(:disciplines).where("disciplines.name like ?", params[:discipline]).uniq
      if results
        @coaches = results.select { |u| u.coach? }
        @users = results.reject   { |u| u.coach? }
      end
    end

    if params[:user]
      @coaches = User.custom_search(params[:user])
    end

    if params[:location] && params[:place]
      if params[:location][:city].present? && params[:place][:name].present?
        @places = Place.joins(:location).where("locations.city = ?", params[:location][:city]).where(name: params[:place][:name])
      elsif params[:location][:city].present?
        @places = Place.joins(:location).where("locations.city = ?", params[:location][:city])
      elsif params[:place][:name].present?
        @places = Place.where(name: params[:place][:name])
      end
    end
  end

  def find
  end

end