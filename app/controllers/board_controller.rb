class BoardController < AuthenticatedController

  load_and_authorize_resource :user

  def index
    @coach_trainings = Training.open.where(coach_id: current_user.id)
    @user_trainings = Training.open.where(user_id: current_user.id)
  end

end
