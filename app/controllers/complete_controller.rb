class CompleteController < AuthenticatedController

  load_and_authorize_resource :user

  def edit
  end

  def update
    if current_player.update_attributes(params[:player])
      current_user.active!
      redirect_to root_path
    else
      render :edit
    end
  end
  
end