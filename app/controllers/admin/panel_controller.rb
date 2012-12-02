class Admin::PanelController < Admin::AdminController

  load_and_authorize_resource :user
  
  def index
  end
  
end
