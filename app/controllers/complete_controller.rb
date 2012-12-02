class CompleteController < UserController

  load_and_authorize_resource :user

  def edit
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to root_path
    else
      render :edit
    end
  end
end