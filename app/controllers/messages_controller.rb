class MessagesController < AuthenticatedController
  def index
    # current_user.messages
  end

  def show
    # current_user.messages.find(params[:id])
  end

  def new
    # current_user.messages.build ...
  end
end
