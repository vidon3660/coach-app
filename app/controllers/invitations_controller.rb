class InvitationsController < AuthenticatedController
  def index
    @invitations = current_user.invitation_requests
  end

  def create
    invited = User.find(params[:person_id])
    invitation = Invitation.new(friend: true)
    invitation.invited  = invited
    invitation.inviting = current_user

    if invitation.save
      redirect_to player_path(invited), notice: "Invitation to friend sent successfully."
    else
      redirect_to player_path(invited), alert: "Error"
    end
  end

  def training
    invited = User.find(params[:person_id])

    if current_user.coach
      invitation = Invitation.new
      invitation.training = true
      invitation.invited  = invited
      invitation.inviting = current_user

      if invitation.save
        redirect_to player_path(invited), notice: "Invitation to training sent successfully."
      else
        redirect_to player_path(invited), alert: "Error"
      end
    else
      redirect_to player_path(invited), alert: "Sorry, you are not coach."
    end
  end

  def update
    invitation = Invitation.find(params[:id])
    invitation.update_attributes(params[:invitation])

    if invitation.accepted?
      invitation.make_relationship
      flash[:notice] = "You add #{invitation.inviting.name} to your friends."
    elsif invitation.rejected?
      flash[:notice] = "You reject invitation."
    end
    redirect_to invitations_path
  end
end
