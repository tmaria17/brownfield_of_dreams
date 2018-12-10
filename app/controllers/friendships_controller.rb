class FriendshipsController <ApplicationController

  def create
    friendship = current_user.friendships.create(friend_id: params[:friend_id])
    friendship.save
    friend = User.find_by(github_id: params[:friend_id])
    flash[:success] = "You have added #{friend.first_name} #{friend.last_name} as a friend."
    redirect_to dashboard_path
  end

end
