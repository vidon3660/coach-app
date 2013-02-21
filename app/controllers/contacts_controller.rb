class ContactsController < AuthenticatedController

  def index
    @friends = current_user.friends
    @trained_users = current_user.trained_users
    @coaches = current_user.user_coaches
  end
  
end
