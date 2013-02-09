class UserProhibitionsController < AuthenticatedController

  def create
    current_user.prohibitions << Prohibition.find(params[:prohibition])
    redirect_to profile_about_path
  end

end
