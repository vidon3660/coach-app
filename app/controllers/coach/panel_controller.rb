class Coach::PanelController < Coach::CoachController

  load_and_authorize_resource :user
  
  def index
  end
end