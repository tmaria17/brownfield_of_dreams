class UserDashboardFacade

  def initialize(user)
    @user = user
  end

  def token
   @user.token
  end

  def user_name
    @user.name
  end

  def followers
    @followers ||= github_service.get_followers.map do |follower_data|
                  Follower.new(follower_data)
                end
  end

  def repos
    @repos ||= github_service.get_repos.map do |repo_data|
                  Repo.new(repo_data)
                end
  end

  def following
    @following ||= github_service.get_followed_users.map do |following_data|
                  Follower.new(following_data)
                end
    end

  def github_service
    GithubService.new(token)
  end

  private
  attr_reader :user
end
