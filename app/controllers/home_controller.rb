class HomeController < AuthenticatedController

  load_and_authorize_resource :user

  def index
  end
  
end
