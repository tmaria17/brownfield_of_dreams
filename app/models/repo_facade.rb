class RepoFacade

  def repos
    github_service.get_repos.map do |repo_data|
      Repo.new(repo_data)
    end.first(5)
  end
  def github_service
    GithubService.new
  end
end
