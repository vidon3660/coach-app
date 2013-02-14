class EventsController < AuthenticatedController
  layout "user"

  def show
    @event = Event.find(params[:id])
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      current_user.events << @event
      redirect_to '/calendar'
    else
      render :show
    end
  end
end
