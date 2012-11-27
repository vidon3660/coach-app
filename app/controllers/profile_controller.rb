class ProfileController < ApplicationController
  def index
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
