class ContactsController < AuthenticatedController

  def index
    @contacts = current_user.contacts
  end
  
end
