class InvitationsController < AuthenticatedController
  def index
    @invitations = current_user.invitation_requests
  end

  def show
    @invitation = Invitation.find(params[:id])
  end

  def create
    invited = User.find(params[:person_id])

    begin
      if current_user.invited << invited
        redirect_to person_path(invited), notice: "Invitation sent successfully."
      end
    rescue
      redirect_to person_path(invited), alert: "Error"
    end
  end

  def update
    invitation = Invitation.find(params[:id])
    invitation.update_attributes(params[:invitation])

    if invitation.accepted?
      invitation.make_relationship
      flash[:notice] = "You add #{invitation.inviting.name} to your contacts."
    elsif invitation.rejected?
      flash[:notice] = "You reject invitation."
    end
    redirect_to invitations_path
  end
end
