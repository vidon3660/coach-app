class FriendshipsController < ApplicationController

  def destroy
    Friendship.find(params[:id]).destroy
    redirect_to :back, notice: "You remove user from friendships."
  end

end
