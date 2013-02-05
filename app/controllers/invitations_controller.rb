class InvitationsController < AuthenticatedController
  def index
    @invitations = current_user.invitation_requests.where(status: "expectant")
  end

  def show
    @invitation = Invitation.find(params[:id])
  end

  def create
    invited = User.find(params[:person_id])
    user = invited
    invitation = Invitation.new
    invitation.training = params[:training] if current_user.coach
    invitation.invited  = invited
    invitation.inviting = current_user

    if invitation.save
      redirect_to player_path(user), notice: "Invitation sent successfully."
    else
      redirect_to player_path(user), alert: "Error"
    end
  end

  def training
    invited = User.find(params[:person_id])
    user = invited

    if current_user.coach
      contact = current_user.relationships.find_by_contact_id(params[:person_id])
      if contact
        contact.training = true
        contact.save
        redirect_to player_path(user), notice: "Add to training successfully."
      else
        invitation = Invitation.new
        invitation.training = params[:training]
        invitation.invited  = invited
        invitation.inviting = current_user

        if invitation.save
          redirect_to player_path(user), notice: "Invitation sent successfully."
        else
          redirect_to player_path(user), alert: "Error"
        end
      end
    else
      redirect_to player_path(invited), alert: "Error"
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
