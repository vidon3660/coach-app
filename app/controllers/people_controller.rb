class PeopleController < UserController

  def show
    @user = User.find(params[:id])

    if @user.active?
      render :show
    else
      redirect_to root_path, notice: "Sorry"
    end
  end

end
