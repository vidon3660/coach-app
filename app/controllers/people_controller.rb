class PeopleController < AuthenticatedController

  def show
    @user = User.find(params[:id])

    if @user.active?
      render :show
    else
      redirect_to root_path, notice: "Sorry"
    end
  end

end
