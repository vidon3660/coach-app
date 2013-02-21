class CoachesController < AuthenticatedController
  def index
    @users = []
    if params[:user]
      # TODO: Thinking sphinx here!
      if params[:user][:city].present?
        @users = User.coaches.where("city like ?", params[:user][:city]).order(:last_name)
      elsif params[:user][:city].present? && params[:user][:discipline_ids].present?
        @users = User.coaches.joins(:disciplines).where("users.city like ? and user_disciplines.is_coach='true' and disciplines.id in (?)", params[:user][:city], params[:user][:discipline_ids].map(&:to_i))
      elsif params[:user][:discipline_ids].present?
        @users = User.coaches.joins(:disciplines).where("user_disciplines.is_coach='true' and disciplines.id in (?)", params[:user][:discipline_ids].map(&:to_i))
      end
    end
  end
end
