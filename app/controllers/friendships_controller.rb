class FriendshipsController <ApplicationController

  def create
    friend = User.find_by(github_id: params[:friend_id])
      if friend == nil
        flash[:error] = "This friendship could not be created. "
        redirect_to dashboard_path
      else
        friendship = current_user.friendships.create(friend_id: params[:friend_id])
        friendship.save
        flash[:success] = "You have added #{friend.first_name} #{friend.last_name} as a friend."
        redirect_to dashboard_path
      end
  end
end
