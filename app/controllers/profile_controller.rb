class ProfileController < AuthenticatedController

  load_and_authorize_resource :user

  def index
    @user = current_user
  end

  def about
    @parameters       = current_user.parameters.order("created_at desc")
    @parameter        = Parameter.new
    @prohibitions     = current_user.prohibitions
    @user_prohibition = ProhibitionUser.new
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to profile_path, notice: t('devise.registrations.updated')
    else
      render :index
    end
  end
end
