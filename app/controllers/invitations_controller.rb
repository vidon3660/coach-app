class InvitationsController < UserController
  def index
  end

  def show
  end

  def create
    invited = User.find(params[:person_id])

    if current_user.invited << invited
      redirect_to person_path(invited), notice: "Invitation sent successfully."
    else
      redirect_to person_path(invited), alert: "Error"
    end
  end
end
