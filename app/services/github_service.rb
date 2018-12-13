class GithubService

  def initialize(token)
    @token = "token #{token}"
  end

  def get_repos
    get_json("/user/repos?per_page=5")
  end

  def get_followers
    get_json("/user/followers")
  end

  def get_invitee_info(handle)
    json = get_json("/users/#{handle}")
     {email:json[:email], name:json[:name]}
  end

  def get_followed_users
    get_json("/user/following")
  end

  private

  def conn
    url = "https://api.github.com"
    Faraday.new(url: url) do |faraday|
        faraday.adapter Faraday.default_adapter
        faraday.headers["Authorization"] = @token
    end
  end

  def get_json(url)
    JSON.parse(conn.get(url).body, symbolize_names: true)
  end
end
