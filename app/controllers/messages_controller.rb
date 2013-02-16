class MessagesController < AuthenticatedController
  def index
    @messages = current_user.received_messages
  end

  def sent
    @messages = current_user.sent_messages
  end

  def show
    @message = Message.read_message(params[:id], current_user)
  end

  def new
    @recipient = User.find(params[:person_id])
    @message = Message.new

    if params[:message_id]
      parent_message      = Message.find(params[:message_id])
      @message.subject    = "[RE]: #{parent_message.subject}" if parent_message
    end
  end

  def create
    @recipient = User.find(params[:person_id])
    @message = Message.new
    @message.subject = params[:message][:subject] if params[:message]
    @message.body = params[:message][:body]       if params[:message]
    @message.sender = current_user
    @message.recipient = @recipient
    if @message.save
      redirect_to sent_messages_path, notice: "Sent message successful"
    else
      render :new
    end
  end

  def destroy
    Message.find(params[:id]).mark_deleted(current_user)
    redirect_to messages_path
  end
end
