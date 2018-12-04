class RepoFacade
  # def initialize(username)
  #   @username = username
  # end
  
  def repos
    github_service.get_repos.map do |repo_data|
      Repo.new(repo_data)
    end
  end
  def github_service
    GithubService.new
  end
end
