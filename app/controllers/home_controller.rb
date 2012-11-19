class HomeController < ApplicationController

  def index
    render "unsigned" unless user_signed_in?
  end
  
end
