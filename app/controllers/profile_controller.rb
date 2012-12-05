class ProfileController < UserController

  load_and_authorize_resource :user

  def index
  end

  def show
    @user = User.find(params[:id])
    if @user.active?
      render :show
    else
      redirect_to root_path, notice: "Sorry"
    end
  end

  def informations
  end

  def update
    if current_user.update_attributes(params[:user])
      redirect_to profile_informations_path, notice: t('devise.registrations.updated')
    else
      render :informations
    end
  end
end
