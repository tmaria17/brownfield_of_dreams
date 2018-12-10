class FriendshipsController <ApplicationController

  def create
    friendship = current_user.friendships.create(friend_id: params[:friend_id])
    friendship.save
    redirect_to dashboard_path
  end

end
