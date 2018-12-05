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

  def repos
    @repos ||= github_service.get_repos.map do |repo_data|
                  Repo.new(repo_data)
                end
  end

  def github_service
    GithubService.new(token)
  end

  private
  attr_reader :user
end
