class FriendshipsController < ApplicationController

  def create
    # friend = User.find_by(github_id: params[:friend_id])
    friendship = current_user.friendships.create(friend_id: params[:friend_id])
    friendship.save
    redirect_to dashboard_path
  end

end
