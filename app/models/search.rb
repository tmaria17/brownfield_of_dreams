class Search
  def initialize(user_handle, token)
    @user_handle = user_handle
    @token = token
  end

  def invitee_info
    github_service.get_invitee_info(@user_handle)
  end

  def github_service
    GithubService.new(@token)
  end
end
