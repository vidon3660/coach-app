class ParametersController < ApplicationController

  def create
    parameter = current_user.parameters.build(params[:parameter])
    if parameter.save
      flash[:notice] = "Add successful."
    else
      flash[:alert] = "Something is wrong."
    end
    redirect_to profile_informations_path
  end

end
